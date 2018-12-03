import XCTest
@testable import TaxJar

final class CalculateRequestTests: XCTestCase {
    let request: Tax.CalculateRequest = {
        let from = Address(country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")
        let to = Address(country: .unitedStates, zip: "90002", state: .ca, city: "Los Angeles", street: "1335 E 103rd St")
        let nexus = [Address(id: "Main Location", country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")]
        let items = [LineItem(id: "1", quantity: 1, taxCode: "20010", price: 15, discount: 0)]
        return Tax.CalculateRequest(from: from, to: to, amount: 15, shipping: 1.5, customer: "31415", nexus: nexus, items: items)
    }()
    
    func testInit()throws {
        XCTAssertEqual(self.request.from, Address(country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive"))
        XCTAssertEqual(self.request.to, Address(country: .unitedStates, zip: "90002", state: .ca, city: "Los Angeles", street: "1335 E 103rd St"))
        XCTAssertEqual(self.request.items, [LineItem(id: "1", quantity: 1, taxCode: "20010", price: 15, discount: 0)])
        XCTAssertEqual(self.request.amount, 15)
        XCTAssertEqual(self.request.shipping, 1.5)
        XCTAssertEqual(self.request.customer, "31415")
        XCTAssertEqual(self.request.nexus, [
            Address(id: "Main Location", country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(self.request), encoding: .utf8)!
        let json =
            "{\"from_state\":\"CA\",\"nexus_addresses\":[{\"id\":\"Main Location\",\"country\":\"US\",\"state\":\"CA\",\"zip\":\"92093\"," +
            "\"city\":\"La Jolla\",\"street\":\"9500 Gilman Drive\"}],\"shipping\":1.5,\"amount\":15,\"from_zip\":\"92093\"," +
            "\"from_country\":\"US\",\"line_items\":[{\"quantity\":1,\"id\":\"1\",\"discount\":0,\"product_tax_code\":\"20010\"," +
            "\"unit_price\":15}],\"from_street\":\"9500 Gilman Drive\",\"to_country\":\"US\",\"to_city\":\"Los Angeles\"," +
            "\"to_street\":\"1335 E 103rd St\",\"to_state\":\"CA\",\"from_city\":\"La Jolla\",\"customer_id\":\"31415\",\"to_zip\":\"90002\"}"
        
        
        var index = 0
        for (g, j) in zip(generated, json) {
            if g != j {
                XCTAssertEqual(g, j)
                break
            }
            index += 1
        }
        
        XCTAssertEqual(generated, json)
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
        
        try XCTAssertEqual(decoder.decode(Tax.CalculateRequest.self, from: json), self.request)
    }
    
    static var allTests: [(String, (CalculateRequestTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


