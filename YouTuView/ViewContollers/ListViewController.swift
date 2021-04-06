import UIKit

private enum Section: Hashable {
    case main
}

struct Item: Hashable {
    let videos: [VideoInfo]

    init(videos: [VideoInfo]) {
        self.videos = videos
    }

    private let identifier = UUID()

    static let all = [
        Item(videos: [])
    ]
}

final class ListViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = .white
    }

    required init?(coder: NSCoder) { fatalError() }

    private lazy var collectionView: UICollectionView = .init(frame: self.view.bounds, collectionViewLayout: createLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
}

// MARK: Layout
extension ListViewController {
    // Use UICollectionViewList
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

// MARK: DataSource
// Not Inheriting UICollectionViewDataSource, but works like it is
extension ListViewController {
    private func configureHierachy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.delegate = self
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SuggestCollectionViewCell, Item> { cell, indexPath, item in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            collectionView, indexPath, item -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Item.all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: Delegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
