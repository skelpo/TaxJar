import Vapor

public final class TaxJarProvider: Provider {
    public let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public func register(_ services: inout Services) throws {
        services.register(Configuration(key: self.key))
        
        services.register(SalesTax.self)
    }
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return container.future()
    }
}

public struct Configuration: Service {
    public let key: String
}
