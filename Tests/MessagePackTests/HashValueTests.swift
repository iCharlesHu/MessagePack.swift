import Foundation
import XCTest
@testable import MessagePack

class HashValueTests: XCTestCase {
    static var allTests = {
        return [
            ("testNilHashValue", testNilHashValue),
            ("testBoolHashValue", testBoolHashValue),
            ("testIntHashValue", testIntHashValue),
            ("testUIntHashValue", testUIntHashValue),
            ("testFloatHashValue", testFloatHashValue),
            ("testDoubleHashValue", testDoubleHashValue),
            ("testStringHashValue", testStringHashValue),
            ("testBinaryHashValue", testBinaryHashValue),
            ("testArrayHashValue", testArrayHashValue),
            ("testMapHashValue", testMapHashValue),
            ("testExtendedHashValue", testExtendedHashValue),
        ]
    }()

    func testNilHashValue() {
        XCTAssertEqual(MessagePackValue.nil.hashValue, 0.hashValue);
    }

    func testBoolHashValue() {
        XCTAssertEqual(MessagePackValue.bool(true).hashValue, true.hashValue)
        XCTAssertEqual(MessagePackValue.bool(false).hashValue, false.hashValue)
    }

    func testIntHashValue() {
        XCTAssertEqual(MessagePackValue.int(-1).hashValue, Int64(-1).hashValue)
        XCTAssertEqual(MessagePackValue.int(0).hashValue, Int64(0).hashValue)
        XCTAssertEqual(MessagePackValue.int(1).hashValue, Int64(1).hashValue)
    }

    func testUIntHashValue() {
        XCTAssertEqual(MessagePackValue.uint(0).hashValue, UInt64(0).hashValue)
        XCTAssertEqual(MessagePackValue.uint(1).hashValue, UInt64(1).hashValue)
        XCTAssertEqual(MessagePackValue.uint(2).hashValue, UInt64(2).hashValue)
    }

    func testFloatHashValue() {
        XCTAssertEqual(MessagePackValue.float(0).hashValue, Float(0).hashValue)
        XCTAssertEqual(MessagePackValue.float(1.618).hashValue, Float(1.618).hashValue)
        XCTAssertEqual(MessagePackValue.float(3.14).hashValue, Float(3.14).hashValue)
    }

    func testDoubleHashValue() {
        XCTAssertEqual(MessagePackValue.double(0).hashValue, Double(0).hashValue)
        XCTAssertEqual(MessagePackValue.double(1.618).hashValue, Double(1.618).hashValue)
        XCTAssertEqual(MessagePackValue.double(3.14).hashValue, Double(3.14).hashValue)
    }

    func testStringHashValue() {
        XCTAssertEqual(MessagePackValue.string("").hashValue, "".hashValue)
        XCTAssertEqual(MessagePackValue.string("MessagePack").hashValue, "MessagePack".hashValue)
    }

    func testBinaryHashValue() {
        XCTAssertEqual(MessagePackValue.binary(Data()).hashValue, Data().hashValue)
        XCTAssertEqual(MessagePackValue.binary(Data([0x00, 0x01, 0x02, 0x03, 0x04])).hashValue,
                       Data([0x00, 0x01, 0x02, 0x03, 0x04]).hashValue)
    }

    func testArrayHashValue() {
        let values: [MessagePackValue] = [1, true, ""]
        XCTAssertEqual(MessagePackValue.array(values).hashValue, values.hashValue)
    }

    func testMapHashValue() {
        let values: [MessagePackValue: MessagePackValue] = [
            "a": "apple",
            "b": "banana",
            "c": "cookie",
        ]
        XCTAssertEqual(MessagePackValue.map(values).hashValue, values.hashValue)
    }

    func testExtendedHashValue() {
        let case1Type: Int8 = 5
        let case1Data: Data = Data()
        var hasher1: Hasher = Hasher()
        hasher1.combine(case1Type)
        hasher1.combine(case1Data)
        let hash1: Int = hasher1.finalize()
        XCTAssertEqual(MessagePackValue.extended(case1Type, case1Data).hashValue, hash1)

        let case2Type: Int8 = 42
        let case2Data: Data = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        var hasher2: Hasher = Hasher()
        hasher2.combine(case2Type)
        hasher2.combine(case2Data)
        let hash2: Int = hasher2.finalize()
        XCTAssertEqual(MessagePackValue.extended(case2Type, case2Data).hashValue, hash2)
    }
}
