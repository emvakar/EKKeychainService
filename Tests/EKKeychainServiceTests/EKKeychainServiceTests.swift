import XCTest
@testable import EKKeychainService

extension EKFieldKey {
    static var test1: Self { "test_key1" }
    static var test2: Self { "test_key2" }
}

final class EKKeychainServiceTests: XCTestCase {

    let testValue = "test"

    func test1_setValue() throws {
        EKKeychainService.shared.set(testValue, withKey: .test1)

        let value = EKKeychainService.shared.getString(withKey: .test1)
        XCTAssert(value == testValue)
    }

    func test2_removeValue() throws {
        let value = EKKeychainService.shared.getString(withKey: .test1)
        XCTAssert(value == testValue)
        EKKeychainService.shared.removeObject(withKey: .test1)
        let clearedValue = EKKeychainService.shared.getString(withKey: .test1)
        XCTAssertNil(clearedValue)
    }

    func test3_removeSomeValues() throws {
        EKKeychainService.shared.set(testValue, withKey: .test1)
        EKKeychainService.shared.set(testValue, withKey: .test2)

        let new1 = EKKeychainService.shared.getString(withKey: .test1)
        let new2 = EKKeychainService.shared.getString(withKey: .test2)

        XCTAssert(new1 == testValue)
        XCTAssert(new2 == testValue)

        EKKeychainService.shared.removeObjects(withKey: .test1, .test2)

        let value1 = EKKeychainService.shared.getString(withKey: .test1)
        let value2 = EKKeychainService.shared.getString(withKey: .test2)

        XCTAssertNil(value1)
        XCTAssertNil(value2)
    }
}
