import UIKit
import SnapKit

final class ItemDetailCell: UICollectionViewListCell {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) { fatalError() }

    var videoInfo: VideoInfo? {
        didSet {
            configure()
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()

    private let createrNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(iconImage)
        contentView.addSubview(createrNameLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }

        iconImage.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-4)
            $0.width.height.equalTo(40)
        }

        createrNameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalTo(iconImage)
        }
    }

    private func configure() {
        guard let videoInfo = videoInfo else { return }

        titleLabel.text = videoInfo.videoTitle
        subTitleLabel.text = videoInfo.viewsCount + " views・" + videoInfo.uploadedTime
        iconImage.image = videoInfo.icon
        createrNameLabel.text = videoInfo.createrName
    }
}
