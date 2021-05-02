import UIKit

final class WatchViewController: UIViewController {

    init(video: VideoInfo) {
        self.video = video
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    private let video: VideoInfo

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        self.view.addSubview(videoPlayerImageView)

        videoPlayerImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(videoPlayerImageView.snp.width).multipliedBy(720.0 / 1280.0)
        }
    }

    private lazy var videoPlayerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.video.thumbnail
        return imageView
    }()
}

