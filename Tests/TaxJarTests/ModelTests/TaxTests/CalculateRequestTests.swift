import XCTest
@testable import TaxJar

final class CalculateRequestTests: XCTestCase {
    func testInit()throws {
        let address = Address(country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")
        
        XCTAssertNil(address.id)
        XCTAssertEqual(address.country, .unitedStates)
        XCTAssertEqual(address.zip, "92093")
        XCTAssertEqual(address.state, .ca)
        XCTAssertEqual(address.city, "La Jolla")
        XCTAssertEqual(address.street, "9500 Gilman Drive")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let address = Address(country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")
        let json = try String(data: encoder.encode(address), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"country\":\"us\",\"state\":\"CA\",\"zip\":\"92093\",\"city\":\"La Jolla\",\"street\":\"9500 Gilman Drive\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "from_country": "US",
            "from_zip": "92093",
            "from_state": "CA",
            "from_city": "La Jolla",
            "from_street": "9500 Gilman Drive",
            "to_country": "US",
            "to_zip": "90002",
            "to_state": "CA",
            "to_city": "Los Angeles",
            "to_street": "1335 E 103rd St",
            "amount": 15,
            "shipping": 1.5,
            "customer_id": "31415",
            "nexus_addresses": [
                {
                    "id": "Main Location",
                    "country": "US",
                    "zip": "92093",
                    "state": "CA",
                    "city": "La Jolla",
                    "street": "9500 Gilman Drive"
                }
            ],
            "line_items": [
                {
                    "id": "1",
                    "quantity": 1,
                    "product_tax_code": "20010",
                    "unit_price": 15,
                    "discount": 0
                }
            ]
        }
        """.data(using: .utf8)!
        
        let from = Address(country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")
        let to = Address(country: .unitedStates, zip: "90002", state: .ca, city: "Los Angeles", street: "1335 E 103rd St")
        let nexus = [Address(id: "Main Location", country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")]
        let items = [LineItem(id: "1", quantity: 1, taxCode: "20010", price: 15, discount: 0)]
        let request = Tax.CalculateRequest(from: from, to: to, amount: 15, shipping: 1.5, customer: "31415", nexus: nexus, items: items)
        
        try XCTAssertEqual(decoder.decode(Tax.CalculateRequest.self, from: json), request)
    }
    
    static var allTests: [(String, (CalculateRequestTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


