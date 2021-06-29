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
        try EKKeychainService.shared.set(stringValue, withKey: .test1)

        let value: String = try EKKeychainService.shared.get(by: .test1)
        XCTAssert(value == stringValue)
    }

    func test2_boolValue() throws {
        try EKKeychainService.shared.set(boolValue, withKey: .bool)

        let value: Bool = try EKKeychainService.shared.get(by: .bool)
        XCTAssert(value == boolValue)
    }

    func test3_dataValue() throws {
        try EKKeychainService.shared.set(dataValue, withKey: .data)

        let value: Data = try EKKeychainService.shared.get(by: .data)
        XCTAssert(value == dataValue)
    }

    func test4_removeValue() throws {
        let value: String = try EKKeychainService.shared.get(by: .test1)
        
        XCTAssert(value == stringValue)
        EKKeychainService.shared.removeObject(withKey: .test1)
        
        do {
            let _: String = try EKKeychainService.shared.get(by: .test1)
        } catch {
            XCTAssertEqual(
                error as! EKKeychainService.EKKeychainError,
                EKKeychainService.EKKeychainError.getEmpty
            )
        }
    }

    func test5_removeSomeValues() throws {
        try EKKeychainService.shared.set(stringValue, withKey: .test1)
        try EKKeychainService.shared.set(stringValue, withKey: .test2)
        try EKKeychainService.shared.set(boolValue, withKey: .bool)
        try EKKeychainService.shared.set(dataValue, withKey: .data)

        let new1: String = try EKKeychainService.shared.get(by: .test1)
        let new2: String = try EKKeychainService.shared.get(by: .test2)
        let new3: Bool = try EKKeychainService.shared.get(by: .bool)
        let new4: Data = try EKKeychainService.shared.get(by: .data)

        XCTAssertNotNil(new1)
        XCTAssertNotNil(new2)
        XCTAssertNotNil(new3)
        XCTAssertNotNil(new4)

        EKKeychainService.shared.removeObjects(withKey: .test1, .test2, .bool, .data)

        // 1
        do {
            let _: String = try EKKeychainService.shared.get(by: .test1)
        }
        catch {
            XCTAssertEqual(
                error as! EKKeychainService.EKKeychainError,
                EKKeychainService.EKKeychainError.getEmpty
            )
        }
        
        // 2
        do {
            let _: String = try EKKeychainService.shared.get(by: .test2)
        }
        catch {
            XCTAssertEqual(
                error as! EKKeychainService.EKKeychainError,
                EKKeychainService.EKKeychainError.getEmpty
            )
        }
        
        // 3
        do {
            let _: Bool = try EKKeychainService.shared.get(by: .bool)
        }
        catch {
            XCTAssertEqual(
                error as! EKKeychainService.EKKeychainError,
                EKKeychainService.EKKeychainError.getEmpty
            )
        }
        
        // 4
        do {
            let _: Data = try EKKeychainService.shared.get(by: .data)
        }
        catch {
            XCTAssertEqual(
                error as! EKKeychainService.EKKeychainError,
                EKKeychainService.EKKeychainError.getEmpty
            )
        }
    }
}
