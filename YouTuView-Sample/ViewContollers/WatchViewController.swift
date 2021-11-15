import UIKit

final class WatchViewController: UIViewController {

    init(video: VideoInfo) {
        self.video = video
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    private let video: VideoInfo
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupViews()
        configureDataSource()
    }

    private func setupViews() {
        view.addSubview(videoPlayerImageView)
        view.addSubview(videoListView)

        videoPlayerImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(videoPlayerImageView.snp.width).multipliedBy(720.0 / 1280.0)
        }

        videoListView.snp.makeConstraints {
            $0.top.equalTo(videoPlayerImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    private lazy var videoPlayerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.video.thumbnail
        imageView.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(playerViewDidSwipeDown))
        imageView.addGestureRecognizer(panGesture)
        return imageView
    }()

    private lazy var videoListView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: self.view.bounds, collectionViewLayout: self.createLayout())
        collectionView.delegate = self
        collectionView.register(SuggestCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SuggestCollectionViewCell.self))
        return collectionView
    }()
    
    @objc private func playerViewDidSwipeDown(gesture: UIPanGestureRecognizer) {
        let move = gesture.translation(in: gesture.view)
        guard move.y > 0 else {
            view.transform = .identity
            return
        }

        if gesture.state == .changed {
            view.transform = CGAffineTransform(translationX: 0, y: move.y)
        } else if gesture.state == .ended {
            if move.y > UIScreen.main.bounds.height / 3 {
                self.dismiss(animated: true, completion: nil)
            } else {
                view.transform = .identity
            }
        }
    }
}

// MARK: Layout
extension WatchViewController {
    // Use UICollectionViewList
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

// MARK: DataSource
// Not Inheriting UICollectionViewDataSource, but works like it is
extension WatchViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SuggestCollectionViewCell, Item> { cell, indexPath, item in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: videoListView) {
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
extension WatchViewController: UICollectionViewDelegate {
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
