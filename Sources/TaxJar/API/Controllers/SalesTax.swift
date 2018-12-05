import TaxCalculator
import Vapor

public final class SalesTax: ServiceType {
    public static func makeService(for worker: Container) throws -> SalesTax {
        return self.init(container: worker)
    }
    
    public let container: Container
    
    public init(container: Container) {
        self.container = container
    }
    
    public func tax(for order: Tax.CalculateRequest) -> Future<Tax> {
        do {
            let key = try self.container.make(Configuration.self).key
            
            let body = try JSONEncoder().encode(order)
            let http = HTTPRequest(
                method: .POST,
                url: Environment.production.domain + "/v2/taxes",
                headers: ["Authorization": "Bearer " + key, "Content-Type": "application/json"],
                body: body
            )
            let request = Request(http: http, using: self.container)
            
            let response = try self.container.client().send(request)
            return response.flatMap { return $0.content.get(Tax.self, at: "tax") }
            
        } catch let error {
            return self.container.future(error: error)
        }
    }
}

extension SalesTax: TaxCalculator {
    public func tax(for input: Tax.CalculateRequest) -> EventLoopFuture<Decimal> {
        return self.tax(for: input).map { (tax: Tax) in tax.rate }
    }
}
