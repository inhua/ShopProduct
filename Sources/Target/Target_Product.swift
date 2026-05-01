// Target_Product.swift - ShopProduct 组件对外暴露的 Target-Action 入口
import UIKit
import ShopBase

@objc(Target_Product)
public class Target_Product: NSObject {
    @objc public func action_viewControllerWithProduct(_ params: [String: Any]?) -> UIViewController? {
        guard let product = params?["product"] as? ProductModel else { return nil }
        return ProductDetailViewController(product: product)
    }
}
