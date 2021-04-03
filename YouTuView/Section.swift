import UIKit

protocol Section {
    var numberOfItems: Int { get }

    var didSelectItem: ((Int) -> Void)? { get }

    func layoutSection() -> NSCollectionLayoutSection

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
