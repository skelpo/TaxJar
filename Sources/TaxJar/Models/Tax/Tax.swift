import Vapor

public struct Tax: Content, Equatable {
    
    /// Total amount of the order.
    public var orderTotal: Decimal
    
    /// Total amount of shipping for the order.
    public var shipping: Decimal
    
    /// Amount of the order to be taxed.
    public var taxable: Decimal
    
    /// Amount of sales tax to collect.
    public var collect: Decimal
    
    /// Overall sales tax rate of the order (amount_to_collect ÷ taxable_amount).
    public var rate: Decimal
    
    /// Whether or not you have nexus for the order based on an address on file, nexus_addresses parameter, or from_ parameters.
    public var hasNexus: Bool
    
    /// Freight taxability for the order.
    public var freightTaxable: Bool
    
    /// Origin-based or destination-based sales tax collection.
    public var source: String?
    
    /// Jurisdiction names for the order.
    public var jurisdictions: Jurisdictions
    
    /// Breakdown of rates by jurisdiction for the order, shipping, and individual line items.
    /// If has_nexus is false or no line items are provided, no breakdown is returned in the response.
    public var breakdown: Breakdown
    
    
    /// Creates a new `Tax` instance.
    ///
    /// - Parameters:
    ///   - orderTotal: Total amount of the order.
    ///   - shipping: Total amount of shipping for the order.
    ///   - taxable: Amount of the order to be taxed.
    ///   - collect: Amount of sales tax to collect.
    ///   - rate: Overall sales tax rate of the order (amount_to_collect ÷ taxable_amount).
    ///   - hasNexus: Whether or not you have nexus for the order based on an address on file, nexus_addresses parameter, or from_ parameters.
    ///   - freightTaxable: Freight taxability for the order.
    ///   - source: Origin-based or destination-based sales tax collection.
    ///   - jurisdictions: Jurisdiction names for the order.
    ///   - breakdown: Breakdown of rates by jurisdiction for the order, shipping, and individual line items.
    public init(
        orderTotal: Decimal,
        shipping: Decimal,
        taxable: Decimal,
        collect: Decimal,
        rate: Decimal,
        hasNexus: Bool,
        freightTaxable: Bool,
        source: String?,
        jurisdictions: Jurisdictions,
        breakdown: Breakdown
    ) {
        self.orderTotal = orderTotal
        self.shipping = shipping
        self.taxable = taxable
        self.collect = collect
        self.rate = rate
        self.hasNexus = hasNexus
        self.freightTaxable = freightTaxable
        self.source = source
        self.jurisdictions = jurisdictions
        self.breakdown = breakdown
    }
    
    enum CodingKeys: String, CodingKey {
        case shipping, rate, jurisdictions, breakdown
        case orderTotal = "order_total_amount"
        case taxable = "taxable_amount"
        case collect = "amount_to_collect"
        case hasNexus = "has_nexus"
        case freightTaxable = "freight_taxable"
        case source = "tax_source"
    }
}
