//
//  ViewController.swift
//  InfiniteCarousel
//
//  Created by filletofish on 10/13/2018.
//  Copyright (c) 2018 filletofish. All rights reserved.
//

import UIKit
import InfiniteCarouselCollectionView

// MARK: - Class

final class ViewController: UIViewController {
    private let colors: [UIColor] = [
        UIColor(red: 19.0/255.0, green: 51.0/255.0, blue: 76.0/255.0, alpha: 1.0),
        UIColor(red: 0.0/255.0, green: 87.0/255.0, blue: 46.0/255.0, alpha: 1.0),
//        UIColor(red: 253.0/255.0, green: 95.0/255.0, blue: 0.0/255.0, alpha: 1.0),
        .white
    ]

    private let emojis: [String] = ["👑", "🙈", "👾"]
    private lazy var pageControl = CustomPageControl.buildPageControl(
        currentPageImage: .init(named: "page-control-current-page"),
        otherPagesImage: .init(named: "page-control-other-page"),
        indicatorColor: colors[.zero].contrastColor
    )
    private let collectionView = CarouselCollectionView(
        frame: .zero,
        collectionViewFlowLayout: UICollectionViewFlowLayout()
    )


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(pageControl)
    
        pageControl.numberOfPages = colors.count
        pageControl.tintColor = .black

        collectionView.register(CVCell.self, forCellWithReuseIdentifier:"id")
        collectionView.reloadData()
        collectionView.carouselDataSource = self
//        collectionView.isAutoscrollEnabled = true
//        collectionView.autoscrollTimeInterval = 3.0
        let size = UIScreen.main.bounds.size
        collectionView.flowLayout.itemSize = CGSize(width: size.width, height: size.height)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.frame = view.bounds

        pageControl.sizeToFit()
        pageControl.frame.origin.y = view.bounds.maxY - 80 - pageControl.frame.height
        pageControl.frame.origin.x = view.bounds.width / 2 - pageControl.frame.width / 2
    }


}

extension ViewController: CarouselCollectionViewDataSource {
    var numberOfItems: Int {
        return colors.count
    }

    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, cellForItemAt index: Int, fakeIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "id",
            for: fakeIndexPath
        ) as! CVCell
        cell.backgroundColor = colors[index]
        cell.label.text = emojis[index]
        return cell
    }

    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, didSelectItemAt index: Int) {
        print("Did select item at \(index)")
    }

    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, didDisplayItemAt index: Int) {
        print(index)
        pageControl.currentPage = index
        pageControl.indicatorColor = colors[index].contrastColor
    }
}

// MARK: - Cell

final class CVCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40.0)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    var redValue: Double { Double(CIColor(color: self).red) }
    var greenValue: Double { Double(CIColor(color: self).green) }
    var blueValue: Double { Double(CIColor(color: self).blue) }
    var alphaValue: Double { Double(CIColor(color: self).alpha) }

    var isLightColor: Bool {
        let hsp = sqrt(0.299 * (redValue * redValue) + 0.587 * (greenValue * greenValue) + 0.114 * (blueValue * blueValue))
        return hsp > 0.5
    }

    var contrastColor: UIColor {
        isLightColor ? .black : .white
    }
}
