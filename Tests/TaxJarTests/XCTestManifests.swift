import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        
        // MARK: - Models
        testCase(TaxJarTests.allTests),
        testCase(EnvironmentTests.allTests),
        testCase(AddressTests.allTests),
        testCase(LineItemTests.allCases),
        testCase(CalculateRequestTests.allCases),
        testCase(JurisdictionsTests.allCases),
        testCase(BreakdownTests.allCases),
        testCase(TaxTests.allCases),
        
        // MARK: - Controllers
        testCase(SaleTaxTests.allCases)
    ]
}
#endif
