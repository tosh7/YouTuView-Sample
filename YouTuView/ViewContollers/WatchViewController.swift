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
        self.view.addSubview(popButton)

        videoPlayerImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(videoPlayerImageView.snp.width).multipliedBy(720.0 / 1280.0)
        }
        popButton.snp.makeConstraints {
            $0.top.equalTo(videoPlayerImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
    }

    private lazy var videoPlayerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.video.thumbnail
        return imageView
    }()

    private lazy var popButton: UIButton = {
        let button = UIButton()
        button.setTitle("pop", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTapp), for: .touchUpInside)
        return button
    }()

    @objc private func buttonDidTapp() {
        self.navigationController?.popViewController(animated: true)
    }
}

