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
        let topSeparator = createSeparatorView()
        let bottomSeparator = createSeparatorView()
        let commentView = CommentView()
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(iconImage)
        contentView.addSubview(createrNameLabel)
        contentView.addSubview(topSeparator)
        contentView.addSubview(bottomSeparator)
        contentView.addSubview(commentView)

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
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(12)
            $0.width.height.equalTo(40)
        }

        createrNameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalTo(iconImage)
        }

        topSeparator.snp.makeConstraints {
            $0.bottom.equalTo(iconImage.snp.top).offset(-8)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }

        bottomSeparator.snp.makeConstraints {
            $0.top.equalTo(iconImage.snp.bottom).offset(8)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }

        commentView.snp.makeConstraints {
            $0.top.equalTo(bottomSeparator.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configure() {
        guard let videoInfo = videoInfo else { return }

        self.accessories = []
        titleLabel.text = videoInfo.videoTitle
        subTitleLabel.text = videoInfo.viewsCount + " views・" + videoInfo.uploadedTime
        iconImage.image = videoInfo.icon
        createrNameLabel.text = videoInfo.createrName
    }

    private func createSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        return view
    }

    class CommentView: UIView {
        init() {
            super.init(frame: .zero)

            let commentLabel: UILabel = {
                let label = UILabel()
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 13)
                label.text = "Comments"
                return label
            }()

            let commentCountText: UILabel = {
                let label = UILabel()
                label.textColor = .gray
                label.font = UIFont.systemFont(ofSize: 13)
                label.text = "1.8K"
                return label
            }()

            let commentText: UILabel = {
                let label = UILabel()
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 10)
                label.text = "In this area, you can see comments. This is demo, who cares?"
                return label
            }()

            self.addSubview(commentLabel)
            self.addSubview(commentCountText)
            self.addSubview(commentText)

            commentLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.top.equalToSuperview().offset(8)
            }

            commentCountText.snp.makeConstraints {
                $0.leading.equalTo(commentLabel.snp.trailing).offset(12)
                $0.centerY.equalTo(commentLabel.snp.centerY)
            }

            commentText.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
                $0.top.equalTo(commentLabel.snp.bottom).offset(4)
                $0.bottom.equalToSuperview().offset(-8)
            }
        }

        required init?(coder: NSCoder) { fatalError() }
    }
}
