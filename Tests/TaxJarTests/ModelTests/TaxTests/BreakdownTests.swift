import XCTest
@testable import TaxJar

final class BreakdownTests: XCTestCase {
    let breakdown = { (stc: Decimal) -> Tax.Breakdown in
        return Tax.Breakdown(
            taxableAmount: 15,
            taxCollectable: 1.35,
            combinedTaxRate: 0.09,
            stateTaxableAmount: 15,
            stateTaxRate: 0.0625,
            stateTaxCollectable: stc,
            countyTaxableAmount: 15,
            countyTaxRate: 0.0025,
            countyTaxCollectable: 0.04,
            cityTaxableAmount: 0,
            cityTaxRate: 0,
            cityTaxCollectable: 0,
            specialDistrictTaxableAmount: 15,
            specialTaxRate: 0.025,
            specialDistrictTaxCollectable: 0.38,
            items: []
        )
    }
    
    func testInit()throws {
        let breakdown = self.breakdown(0.94)
        
        XCTAssertEqual(breakdown.taxableAmount, 15)
        XCTAssertEqual(breakdown.taxCollectable, 1.35)
        XCTAssertEqual(breakdown.combinedTaxRate, 0.09)
        XCTAssertEqual(breakdown.stateTaxableAmount, 15)
        XCTAssertEqual(breakdown.stateTaxRate, 0.0625)
        XCTAssertEqual(breakdown.stateTaxCollectable, 0.94)
        XCTAssertEqual(breakdown.countyTaxableAmount, 15)
        XCTAssertEqual(breakdown.countyTaxRate, 0.0025)
        XCTAssertEqual(breakdown.countyTaxCollectable, 0.04)
        XCTAssertEqual(breakdown.cityTaxableAmount, 0)
        XCTAssertEqual(breakdown.cityTaxRate, 0)
        XCTAssertEqual(breakdown.cityTaxCollectable, 0)
        XCTAssertEqual(breakdown.specialDistrictTaxableAmount, 15)
        XCTAssertEqual(breakdown.specialTaxRate, 0.025)
        XCTAssertEqual(breakdown.specialDistrictTaxCollectable, 0.38)
        XCTAssertEqual(breakdown.items, [])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let breakdown = self.breakdown(Decimal(sign: .plus, exponent: -2, significand: 94))
        let generated = try String(data: encoder.encode(breakdown), encoding: .utf8)!
        let json = "{\"county_tax_rate\":0.0025,\"taxable_amount\":15,\"county_taxable_amount\":15,\"city_taxable_amount\":0,\"special_tax_rate\":0.025,\"tax_collectable\":1.35,\"state_taxable_amount\":15,\"city_tax_collectable\":0,\"special_district_tax_collectable\":0.38,\"special_district_taxable_amount\":15,\"line_items\":[],\"county_tax_collectable\":0.04,\"state_tax_collectable\":0.94,\"city_tax_rate\":0,\"state_tax_rate\":0.0625,\"combined_tax_rate\":0.09}"
        
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
          "taxable_amount": 15,
          "tax_collectable": 1.35,
          "combined_tax_rate": 0.09,
          "state_taxable_amount": 15,
          "state_tax_rate": 0.0625,
          "state_tax_collectable": 0.94,
          "county_taxable_amount": 15,
          "county_tax_rate": 0.0025,
          "county_tax_collectable": 0.04,
          "city_taxable_amount": 0,
          "city_tax_rate": 0,
          "city_tax_collectable": 0,
          "special_district_taxable_amount": 15,
          "special_tax_rate": 0.025,
          "special_district_tax_collectable": 0.38,
          "line_items": []
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Tax.Breakdown.self, from: json), self.breakdown(0.94))
    }
    
    static var allTests: [(String, (BreakdownTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




