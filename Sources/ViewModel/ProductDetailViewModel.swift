// ProductDetailViewModel.swift - 商品详情 ViewModel
import Foundation
import ShopBase

public class ProductDetailViewModel {
    public let product: ProductModel

    public var priceText: String {
        "¥\(String(format: "%.2f", product.price))"
    }

    public var ratingText: String {
        "评分：\(product.rating) | 已售：\(product.sales)"
    }

    public init(product: ProductModel) {
        self.product = product
    }
}
