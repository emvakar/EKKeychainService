//
//  EKKeychainService.swift
//  EKKeychainService
//
//  Created by Emil Karimov on 21.06.2021.
//  Copyright © 2021 Emil Karimov. All rights reserved.
//

import Foundation
import KeychainSwift

final public class EKKeychainService {

    /// Set your accessGroup prefix
    /// e.g.  "[teamID].com.example.all"
    public var keyPrefix: String? {
        didSet {
            guard let keyPrefix = keyPrefix else { return }
            keychain = KeychainSwift(keyPrefix: keyPrefix)
            keychain.accessGroup = keyPrefix
        }
    }

    /// Service singleton
    public static let shared = EKKeychainService()

    private lazy var keychain = KeychainSwift()
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()

    private init() { }

}

// MARK: - Actions (keychain)

extension EKKeychainService {

    /// Persist the inputted object to keychain while assigning its key.
    /// 'String', 'Bool' & 'Data' object types are auto-handled.
    /// Other object types will be convert to data with Codable func
    public func set<T: Codable>(_ object: T?, withKey key: EKFieldKey) throws {
        if let value = object as? String {
            keychain.set(value, forKey: key.description)
        } else if object == nil {
            keychain.delete(key.description)
        } else if let value = object as? Bool {
            keychain.set(value, forKey: key.description)
        } else if let value = object as? Data {
            keychain.set(value, forKey: key.description)
        } else {
            let data = try encoder.encode(object)
            keychain.set(data, forKey: key.description)
        }
    }

    public func get<T: Codable>(by key: EKFieldKey) throws -> T {
        if
            T.self == String.self,
            let value = keychain.get(key.description) as? T {
            return value
        }
        else if
            T.self == Data.self,
            let value = keychain.getData(key.description) as? T {
            return value
        }
        else if
            T.self == Bool.self,
            let value = keychain.getBool(key.description) as? T {
            return value
        }
        else {
            guard
                let data = keychain.getData(key.description)
            else {
                throw EKKeychainError.getEmpty
            }
            let model = try decoder.decode(T.self, from: data)
            return model
        }
    }
    
    public func removeObject(withKey key: EKFieldKey) {
        keychain.delete(key.description)
    }

    public func removeObjects(withKey keys: EKFieldKey...) {
        keys.forEach { keychain.delete($0.description) }
    }
}

// MARK: - Nested types

extension EKKeychainService {
    
    enum EKKeychainError: Error, LocalizedError {
        case getEmpty
        
        public var errorDescription: String? {
            switch self {
            case .getEmpty:
                return "You try to get empty object!"
            }
        }
    }
}
