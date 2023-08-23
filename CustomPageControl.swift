//
//  CustomPageControl.swift
//  BTGMicroFeatures
//
//  Created by Ramon Dias on 05/05/22.
//

import Foundation

public class CustomPageControl: UIPageControl {
    public var currentPageImage: UIImage? {
        didSet {
            updateDots()
        }
    }

    public var otherPagesImage: UIImage? {
        didSet {
            updateDots()
        }
    }

    public var indicatorColor: UIColor = .gray {
        didSet {
            pageIndicatorTintColor = indicatorColor
            currentPageIndicatorTintColor = indicatorColor
        }
    }

    override public var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }

    override public var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    convenience init(
        currentPageImage: UIImage? = nil,
        otherPagesImage: UIImage? = nil,
        indicatorColor: UIColor = .gray,
        numberOfPages: Int,
        currentPage: Int = Int.zero
    ) {
        self.init()
        self.currentPageImage = currentPageImage
        self.otherPagesImage = otherPagesImage
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
        self.indicatorColor = indicatorColor
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 14.0, *) {
            setupiOS14OrAbove()
        } else {
            pageIndicatorTintColor = .clear
            currentPageIndicatorTintColor = .clear
            clipsToBounds = false
        }
    }

    @available(iOS 14.0, *)
    private func setupiOS14OrAbove() {
        for index in Int.zero..<numberOfPages {
            let image = index == currentPage ? currentPageImage : otherPagesImage
            setIndicatorImage(image, forPage: index)
        }

        pageIndicatorTintColor = indicatorColor
        currentPageIndicatorTintColor = indicatorColor
    }

    private func updateDots() {
        if #available(iOS 14.0, *) {
            setupiOS14OrAbove()
        } else {
            subviews.enumerated().forEach { index, subview in
                let imageView: UIImageView
                let otherPagesImage = otherPagesImage?.withRenderingMode(.alwaysTemplate).colored(indicatorColor)
                let currentPageImage = currentPageImage?.withRenderingMode(.alwaysTemplate).colored(indicatorColor)
                if let existingImageView = getImageView(forSubview: subview) {
                    imageView = existingImageView
                } else {
                    imageView = UIImageView(image: otherPagesImage)
                    imageView.center = subview.center
                    subview.addSubview(imageView)
                    subview.clipsToBounds = false
                }
                imageView.image = currentPage == index ? currentPageImage : otherPagesImage
            }
        }
    }

    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            let view = view.subviews.first { view -> Bool in
                view is UIImageView
            } as? UIImageView
            return view
        }
    }

    public static func buildPageControl(
        currentPageImage: UIImage? = nil,
        otherPagesImage: UIImage? = nil,
        indicatorColor: UIColor = .gray,
        numberOfPages: Int = 1,
        currentPage: Int = .zero
    ) -> CustomPageControl {
        CustomPageControl(
            currentPageImage: currentPageImage,
            otherPagesImage: otherPagesImage,
            indicatorColor: indicatorColor,
            numberOfPages: numberOfPages,
            currentPage: currentPage
        )
    }
}

extension UIImage {
    func colored(_ color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            self.draw(at: .zero)
            context.fill(CGRect(x: .zero, y: .zero, width: size.width, height: size.height), blendMode: .sourceAtop)
        }
    }
}
