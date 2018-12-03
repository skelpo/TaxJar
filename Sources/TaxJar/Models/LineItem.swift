import Vapor

/// An item in a transaction.
public struct LineItem: Content, Equatable {
    
    /// Unique identifier of the given line item.
    ///
    /// - Note: Either `amount` or `line_items` parameters are required to perform tax calculations.
    public var id: String?
    
    /// Quantity for the item.
    public var quantity: Int?
    
    /// Product tax code for the item. If omitted, the item will remain fully taxable.
    ///
    /// The coding key string value is `product_tax_code`.
    public var taxCode: String?
    
    /// Unit price for the item.
    ///
    /// The coding key string value is `unit_price`.
    public var price: Decimal?
    
    /// Total discount (non-unit) for the item.
    public var discount: Decimal?
    
    
    /// Creates a new `LineItem` instance.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the given line item.
    ///   - quantity: Quantity for the item.
    ///   - taxCode: Product tax code for the item. If omitted, the item will remain fully taxable.
    ///   - price: Unit price for the item.
    ///   - discount: Total discount (non-unit) for the item.
    public init(id: String?, quantity: Int?, taxCode: String?, price: Decimal?, discount: Decimal?) {
        self.id = id
        self.quantity = quantity
        self.taxCode = taxCode
        self.price = price
        self.discount = discount
    }
    
    enum CodingKeys: String, CodingKey {
        case id, quantity, discount
        case taxCode = "product_tax_code"
        case price = "unit_price"
    }
}
