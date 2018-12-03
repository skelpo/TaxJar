import Vapor

extension Tax {
    
    /// Breakdown of rates by jurisdiction for the order, shipping, and individual line items.
    public struct Breakdown: Content, Equatable {
        
        /// Total amount of the order to be taxed.
        public var taxableAmount: Decimal?
        
        /// Total amount of sales tax to collect.
        public var taxCollectable: Decimal?
        
        /// Overall sales tax rate of the breakdown which includes state, county, city and district tax for the order and shipping if applicable.
        public var combinedTaxRate: Decimal?
        
        /// Amount of the order to be taxed at the state tax rate.
        public var stateTaxableAmount: Decimal?
        
        /// State sales tax rate for given location.
        public var stateTaxRate: Decimal?
        
        /// Amount of sales tax to collect for the state.
        public var stateTaxCollectable: Decimal?
        
        /// Amount of the order to be taxed at the county tax rate.
        public var countyTaxableAmount: Decimal
        
        /// County sales tax rate for given location.
        public var countyTaxRate: Decimal
        
        /// Amount of sales tax to collect for the county.
        public var countyTaxCollectable: Decimal
    
        /// Amount of the order to be taxed at the city tax rate.
        public var cityTaxableAmount: Decimal?
        
        /// City sales tax rate for given location.
        public var cityTaxRate: Decimal?
        
        /// Amount of sales tax to collect for the city.
        public var cityTaxCollectable: Decimal?
        
        /// Amount of the order to be taxed at the special district tax rate.
        public var specialDistrictTaxableAmount: Decimal?
        
        /// Special district sales tax rate for given location.
        public var specialTaxRate: Decimal?
        
        /// Amount of sales tax to collect for the special district.
        public var specialDistrictTaxCollectable: Decimal?
        
        /// Breakdown of rates by line item if applicable.
        public var items: [LineItem]
        
        
        /// Creates a new `Tax.Breakdown` instance.
        ///
        /// - Parameters:
        ///   - taxableAmount: Total amount of the order to be taxed.
        ///   - taxCollectable: Total amount of sales tax to collect.
        ///   - combinedTaxRate: Overall sales tax rate of the breakdown which includes state, county, city
        ///     and district tax for the order and shipping if applicable.
        ///   - stateTaxableAmount: Amount of the order to be taxed at the state tax rate.
        ///   - stateTaxRate: State sales tax rate for given location.
        ///   - stateTaxCollectable: Amount of sales tax to collect for the state.
        ///   - countyTaxableAmount: Amount of the order to be taxed at the county tax rate.
        ///   - countyTaxRate: County sales tax rate for given location.
        ///   - countyTaxCollectable: Amount of sales tax to collect for the county.
        ///   - cityTaxableAmount: Amount of the order to be taxed at the city tax rate.
        ///   - cityTaxRate: City sales tax rate for given location.
        ///   - cityTaxCollectable: Amount of sales tax to collect for the city.
        ///   - specialDistrictTaxableAmount: Amount of the order to be taxed at the special district tax rate.
        ///   - specialTaxRate: Special district sales tax rate for given location.
        ///   - specialDistrictTaxCollectable: Amount of sales tax to collect for the special district.
        ///   - items: Breakdown of rates by line item if applicable.
        public init(
            taxableAmount: Decimal?,
            taxCollectable: Decimal?,
            combinedTaxRate: Decimal?,
            stateTaxableAmount: Decimal?,
            stateTaxRate: Decimal?,
            stateTaxCollectable: Decimal?,
            countyTaxableAmount: Decimal,
            countyTaxRate: Decimal,
            countyTaxCollectable: Decimal,
            cityTaxableAmount: Decimal?,
            cityTaxRate: Decimal?,
            cityTaxCollectable: Decimal?,
            specialDistrictTaxableAmount: Decimal?,
            specialTaxRate: Decimal?,
            specialDistrictTaxCollectable: Decimal?,
            lineItems: [LineItem]
        ) {
            self.taxableAmount = taxableAmount
            self.taxCollectable = taxCollectable
            self.combinedTaxRate = combinedTaxRate
            self.stateTaxableAmount = stateTaxableAmount
            self.stateTaxRate = stateTaxRate
            self.stateTaxCollectable = stateTaxCollectable
            self.countyTaxableAmount = countyTaxableAmount
            self.countyTaxRate = countyTaxRate
            self.countyTaxCollectable = countyTaxCollectable
            self.cityTaxableAmount = cityTaxableAmount
            self.cityTaxRate = cityTaxRate
            self.cityTaxCollectable = cityTaxCollectable
            self.specialDistrictTaxableAmount = specialDistrictTaxableAmount
            self.specialTaxRate = specialTaxRate
            self.specialDistrictTaxCollectable = specialDistrictTaxCollectable
            self.items = lineItems
        }
        
        enum CodingKeys: String, CodingKey {
            case taxableAmount = "taxable_amount"
            case taxCollectable = "tax_collectable"
            case combinedTaxRate = "combined_tax_rate"
            case stateTaxableAmount = "state_taxable_amount"
            case stateTaxRate = "state_tax_rate"
            case stateTaxCollectable = "state_tax_collectable"
            case countyTaxableAmount = "county_taxable_amount"
            case countyTaxRate = "county_tax_rate"
            case countyTaxCollectable = "county_tax_collectable"
            case cityTaxableAmount = "city_taxable_amount"
            case cityTaxRate = "city_tax_rate"
            case cityTaxCollectable = "city_tax_collectable"
            case specialDistrictTaxableAmount = "special_district_taxable_amount"
            case specialTaxRate = "special_tax_rate"
            case specialDistrictTaxCollectable = "special_district_tax_collectable"
            case items = "line_items"
        }
    }
}
