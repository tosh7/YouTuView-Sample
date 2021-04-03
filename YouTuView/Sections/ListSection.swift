import UIKit

struct ListSection: Section {
    var videos: [VideoInfo]
    var numberOfItems: Int { videos.count }

    var didSelectItem: ((Int) -> Void)?

    func layoutSection() -> NSCollectionLayoutSection {

        // Layout for Items
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Layout for groups
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Layout for Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SuggestCollectionViewCell.self), for: indexPath) as! SuggestCollectionViewCell
        cell.setup(info: videos[indexPath.row])
        return cell
    }
}

extension ListSection {
    init(videos: [VideoInfo]) {
        self.videos = videos
    }
}
