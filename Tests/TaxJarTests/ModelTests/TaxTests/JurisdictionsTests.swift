import XCTest
@testable import TaxJar

final class JurisdictionsTests: XCTestCase {
    func testInit()throws {
        let jurisdictions = Tax.Jurisdictions(country: .unitedStates, state: .ca, county: "LOS ANGELES", city: "LOS ANGELES")
        
        XCTAssertEqual(jurisdictions.country, .unitedStates)
        XCTAssertEqual(jurisdictions.state, .ca)
        XCTAssertEqual(jurisdictions.county, "LOS ANGELES")
        XCTAssertEqual(jurisdictions.city, "LOS ANGELES")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let jurisdictions = Tax.Jurisdictions(country: .unitedStates, state: .ca, county: "LOS ANGELES", city: "LOS ANGELES")
        let json = try String(data: encoder.encode(jurisdictions), encoding: .utf8)!
        
        XCTAssertEqual(json, "{\"county\":\"LOS ANGELES\",\"country\":\"US\",\"state\":\"CA\",\"city\":\"LOS ANGELES\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "country": "US",
            "state": "CA",
            "county": "LOS ANGELES",
            "city": "LOS ANGELES"
        }
        """.data(using: .utf8)!
        
        let jurisdictions = Tax.Jurisdictions(country: .unitedStates, state: .ca, county: "LOS ANGELES", city: "LOS ANGELES")
        try XCTAssertEqual(decoder.decode(Tax.Jurisdictions.self, from: json), jurisdictions)
    }
    
    static var allTests: [(String, (JurisdictionsTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



