import XCTest
@testable import EKKeychainService

extension EKFieldKey {
    static var test1: Self { "test_key1" }
    static var test2: Self { "test_key2" }
    static var bool: Self { "test_bool" }
    static var data: Self { "test_data" }
}

final class EKKeychainServiceTests: XCTestCase {

    let stringValue = "test"
    let boolValue = true
    let dataValue = "test".data(using: .utf8)

    func test1_stringValue() throws {
        EKKeychainService.shared.set(stringValue, withKey: .test1)

        let value = EKKeychainService.shared.getString(withKey: .test1)
        XCTAssert(value == stringValue)
    }

    func test2_boolValue() throws {
        EKKeychainService.shared.set(boolValue, withKey: .bool)

        let value = EKKeychainService.shared.getBool(withKey: .bool)
        XCTAssert(value == boolValue)
    }

    func test3_dataValue() throws {
        EKKeychainService.shared.set(dataValue, withKey: .data)

        let value = EKKeychainService.shared.getData(withKey: .data)
        XCTAssert(value == dataValue)
    }

    func test4_removeValue() throws {
        let value = EKKeychainService.shared.getString(withKey: .test1)
        XCTAssert(value == stringValue)
        EKKeychainService.shared.removeObject(withKey: .test1)
        let clearedValue = EKKeychainService.shared.getString(withKey: .test1)
        XCTAssertNil(clearedValue)
    }

    func test5_removeSomeValues() throws {
        EKKeychainService.shared.set(stringValue, withKey: .test1)
        EKKeychainService.shared.set(stringValue, withKey: .test2)
        EKKeychainService.shared.set(boolValue, withKey: .bool)
        EKKeychainService.shared.set(dataValue, withKey: .data)



        let new1 = EKKeychainService.shared.getString(withKey: .test1)
        let new2 = EKKeychainService.shared.getString(withKey: .test2)
        let new3 = EKKeychainService.shared.getBool(withKey: .bool)
        let new4 = EKKeychainService.shared.getData(withKey: .data)

        XCTAssertNotNil(new1)
        XCTAssertNotNil(new2)
        XCTAssertNotNil(new3)
        XCTAssertNotNil(new4)

        EKKeychainService.shared.removeObjects(withKey: .test1, .test2, .bool, .data)

        let value1 = EKKeychainService.shared.getString(withKey: .test1)
        let value2 = EKKeychainService.shared.getString(withKey: .test2)
        let value3 = EKKeychainService.shared.getBool(withKey: .bool)
        let value4 = EKKeychainService.shared.getData(withKey: .data)

        XCTAssertNil(value1)
        XCTAssertNil(value2)
        XCTAssertNil(value3)
        XCTAssertNil(value4)
    }
}
