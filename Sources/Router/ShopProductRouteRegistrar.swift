// ShopProductRouteRegistrar.swift - ShopProduct 路由注册
import ShopRouter
import ShopBase

public final class ShopProductRouteRegistrar: NSObject, MTRouteRegistrable {
    public static func registerRoutes() {
        MTRouter.shared.register(RouterPath.Product.detail) { params in
            guard let product = params?["product"] as? ProductModel else { return nil }
            return ProductDetailViewController(product: product)
        }
    }
}
