import UIKit

private enum Section: Hashable {
    case main
}

struct Item: Hashable {
    let videos: VideoInfo

    init(videos: VideoInfo) {
        self.videos = videos
    }

    private let identifier = UUID()

    static let all = [
        Item(videos: VideoInfo(thumbnail: R.image.thumbnail1()!, icon: R.image.thumbnail1()!, videoTitle: "Let me show you my speciality", createrName: "HikakinTV", viewsCount: "13M", uploadedTime: "2020/2/21")),
        Item(videos: VideoInfo(thumbnail: R.image.thumbnail2()!, icon: R.image.thumbnail1()!, videoTitle: "How to deal with cold", createrName: "HikakinTV", viewsCount: "14M", uploadedTime: "2020/2/23")),
        Item(videos: VideoInfo(thumbnail: R.image.thumbnail3()!, icon: R.image.thumbnail1()!, videoTitle: "Quitting broadcasts", createrName: "HikakinTV", viewsCount: "130K", uploadedTime: "2020/3/20")),
        Item(videos: VideoInfo(thumbnail: R.image.thumbnail4()!, icon: R.image.thumbnail1()!, videoTitle: "Marriage prank!", createrName: "Raphael", viewsCount: "4M", uploadedTime: "2020/3/20"))
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

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(SuggestCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SuggestCollectionViewCell.self))

        configureHierachy()
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
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
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            cell.setup(info: Item.all[indexPath.row].videos)
            return cell
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

        let watchViewController = WatchViewController(video: Item.all[indexPath.row].videos)
        watchViewController.modalPresentationStyle = .overFullScreen
        self.present(watchViewController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .clear
    }
}
