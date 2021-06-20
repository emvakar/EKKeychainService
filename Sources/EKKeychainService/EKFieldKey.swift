//
//  EKFieldKey.swift
//  EKKeychainService
//
//  Created by Emil Karimov on 21.06.2021.
//

public indirect enum EKFieldKey {
    case string(String)
}

// MARK: - ExpressibleByStringLiteral

extension EKFieldKey: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        switch value {
        default:
            self = .string(value)
        }
    }

}

// MARK: - CustomStringConvertible

extension EKFieldKey: CustomStringConvertible {

    public var description: String {
        switch self {
        case .string(let name):
            return name
        }
    }

}

// MARK: - Equatable

extension EKFieldKey: Equatable { }

// MARK: - Hashable

extension EKFieldKey: Hashable { }
