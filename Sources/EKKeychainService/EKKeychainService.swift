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

    private init() { }

}

// MARK: - Actions (keychain)

extension EKKeychainService {

    /// Persist the inputted object to keychain while assigning its key. 'String', 'Bool' & 'Data' object types are auto-handled. Other object types can NOT be stored within the keychain!
    @discardableResult
    public func set(_ object: Any?, withKey key: EKFieldKey) -> Bool {
        if let value = object as? String {
            keychain.set(value, forKey: key.description)
            return true
        } else if object == nil {
            keychain.delete(key.description)
            return true
        } else if let value = object as? Bool {
            keychain.set(value, forKey: key.description)
            return true
        } else if let value = object as? Data {
            keychain.set(value, forKey: key.description)
            return true
        } else {
            return false
        }
    }

    public func getString(withKey key: EKFieldKey) -> String? {
        return keychain.get(key.description)
    }

    public func getData(withKey key: EKFieldKey) -> Data? {
        return keychain.getData(key.description)
    }

    public func getBool(withKey key: EKFieldKey) -> Bool? {
        return keychain.getBool(key.description)
    }

    public func removeObject(withKey key: EKFieldKey) {
        keychain.delete(key.description)
    }

}
