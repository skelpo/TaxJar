import XCTest
@testable import TaxJar

final class AddressTests: XCTestCase {
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
            "country": "us",
            "zip": "92093",
            "state": "CA",
            "city": "La Jolla",
            "street": "9500 Gilman Drive"
        }
        """.data(using: .utf8)!
        
        let address = Address(country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")
        try XCTAssertEqual(decoder.decode(Address.self, from: json), address)
    }
    
    static var allTests: [(String, (AddressTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

