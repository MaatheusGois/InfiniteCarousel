# InfiniteCarousel

[![CI Status](https://img.shields.io/travis/filletofish/InfiniteCarouselCollectionView.svg?style=flat)](https://travis-ci.org/filletofish/InfiniteCarouselCollectionView)
[![Version](https://img.shields.io/cocoapods/v/InfiniteCarouselCollectionView.svg?style=flat)](https://cocoapods.org/pods/InfiniteCarouselCollectionView)
[![License](https://img.shields.io/cocoapods/l/InfiniteCarouselCollectionView.svg?style=flat)](https://cocoapods.org/pods/InfiniteCarouselCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/InfiniteCarouselCollectionView.svg?style=flat)](https://cocoapods.org/pods/InfiniteCarouselCollectionView)

![ezgif com-crop](https://github.com/MaatheusGois/InfiniteCarousel/assets/31082311/fa1a51c2-cf2c-4180-8058-de6244cc1a71)

InfiniteCarousel is a lightweight lib, that provides implementation of **horizontal infinite** collection view to display paginated items of equal-sized items
 
One should use `carouselDataSource` instead of `dataSource` and `delegate`.

For autoscrolling see `isAutoscrollEnabled`.

Underneath algorithm can be described as followed:
- Putting last at the index 0, and first item at the end: [4], [1], [2], [3], [4], [1]
- While scrolling, whenever user reaches the first or the last index – scroll without animation to respectively the same item, but not at the sides.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Prerequisites 
- Use equal-sized cells
- Use fullscreen width cells

## Installation

InfiniteCarousel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InfiniteCarouselCollectionView'
```

## Author

Filipp Fediakov, [Twitter](https://twitter.com/filippfediakov)

Special thanks to [@ilyailya](https://github.com/ilyailya)

## License

InfiniteCarousel is available under the MIT license. See the LICENSE file for more info.
