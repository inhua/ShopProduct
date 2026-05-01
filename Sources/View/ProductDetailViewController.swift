// ProductDetailViewController.swift - 商品详情页
import UIKit
import ShopBase
import ShopMediator

public class ProductDetailViewController: BaseViewController {

    private let viewModel: ProductDetailViewModel

    public init(product: ProductModel) {
        self.viewModel = ProductDetailViewModel(product: product)
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) { fatalError() }

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let productImageView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray5
        return v
    }()

    private let priceLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 24)
        l.textColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1)
        return l
    }()

    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        l.numberOfLines = 0
        return l
    }()

    private let ratingLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textColor = .gray
        return l
    }()

    private let descLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .darkGray
        l.numberOfLines = 0
        return l
    }()

    private let addCartButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("加入购物车", for: .normal)
        b.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 16)
        b.layer.cornerRadius = 22
        return b
    }()

    private let buyButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("立即购买", for: .normal)
        b.backgroundColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 16)
        b.layer.cornerRadius = 22
        return b
    }()

    public override func setupUI() {
        title = "商品详情"
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        [productImageView, priceLabel, nameLabel, ratingLabel, descLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        let bottomBar = UIView()
        bottomBar.backgroundColor = .systemBackground
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomBar)
        [addCartButton, buyButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            bottomBar.addSubview($0)
        }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 300),

            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            descLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 16),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 64),

            addCartButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 16),
            addCartButton.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            addCartButton.widthAnchor.constraint(equalTo: bottomBar.widthAnchor, multiplier: 0.44),
            addCartButton.heightAnchor.constraint(equalToConstant: 44),

            buyButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -16),
            buyButton.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            buyButton.widthAnchor.constraint(equalTo: bottomBar.widthAnchor, multiplier: 0.44),
            buyButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        priceLabel.text = viewModel.priceText
        nameLabel.text = viewModel.product.name
        ratingLabel.text = viewModel.ratingText
        descLabel.text = viewModel.product.description

        addCartButton.addTarget(self, action: #selector(onAddCart), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(onBuy), for: .touchUpInside)
    }

    @objc private func onAddCart() {
        CTMediator.shared.performTarget("Cart", action: "addProduct", params: ["product": viewModel.product])
        showToast("已加入购物车")
    }

    @objc private func onBuy() {
        requireLogin {
            self.showToast("下单功能开发中")
        }
    }
}
