import XCTest
@testable import TaxJar

final class LineItemTests: XCTestCase {
    func testInit()throws {
        let item = LineItem(id: "1", quantity: 1, taxCode: "20010", price: 15, discount: 0)
        
        XCTAssertEqual(item.id, "1")
        XCTAssertEqual(item.quantity, 1)
        XCTAssertEqual(item.taxCode, "20010")
        XCTAssertEqual(item.price, 15)
        XCTAssertEqual(item.discount, 0)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let item = LineItem(id: "1", quantity: 1, taxCode: "20010", price: 15, discount: 0)
        let json = try String(data: encoder.encode(item), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"quantity\":1,\"id\":\"1\",\"discount\":0,\"product_tax_code\":\"20010\",\"unit_price\":15}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "id": "1",
            "quantity": 1,
            "product_tax_code": "20010",
            "unit_price": 15,
            "discount": 0
        }
        """.data(using: .utf8)!
        
        let item = LineItem(id: "1", quantity: 1, taxCode: "20010", price: 15, discount: 0)
        try XCTAssertEqual(decoder.decode(LineItem.self, from: json), item)
    }
    
    static var allTests: [(String, (LineItemTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


