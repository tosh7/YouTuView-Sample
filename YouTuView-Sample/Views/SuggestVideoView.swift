import UIKit
import SnapKit

final class SuggestView: UIView {
    init(info: VideoInfo) {
        super.init(frame: .zero)

        setup(info: info)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private func setup(info: VideoInfo) {
        thumbnailView.image = info.thumbnail
        iconView.image = info.icon
        mainTitleLabel.text = info.videoTitle
        subTitleLabel.text = "\(info.createrName)・\(info.viewsCount) views・\(info.uploadedTime) ago"
    }

    private func setupViews() {
        self.addSubview(thumbnailView)
        self.addSubview(iconView)
        self.addSubview(mainTitleLabel)
        self.addSubview(subTitleLabel)

        thumbnailView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(thumbnailView.snp.width).multipliedBy(780.0 / 1280)
        }

        iconView.snp.makeConstraints {
            $0.top.equalTo(thumbnailView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.height.width.equalTo(30)
        }

        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.top)
            $0.leading.equalTo(iconView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-50)
        }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(mainTitleLabel.snp.leading)
            $0.trailing.equalTo(mainTitleLabel.snp.trailing)
        }
    }
}
