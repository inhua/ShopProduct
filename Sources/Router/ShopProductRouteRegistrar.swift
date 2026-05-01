// ShopProductRouteRegistrar.swift - ShopProduct 路由自注册
import ShopRouter
import ShopBase

public final class ShopProductRouteRegistrar: NSObject, MTRouteRegistrable {
    override public class func initialize() {
        super.initialize()
        guard self === ShopProductRouteRegistrar.self else { return }
        registerRoutes()
    }

    public static func registerRoutes() {
        MTRouter.shared.register(RouterPath.Product.detail) { params in
            guard let product = params?["product"] as? ProductModel else { return nil }
            return ProductDetailViewController(product: product)
        }
    }
}
