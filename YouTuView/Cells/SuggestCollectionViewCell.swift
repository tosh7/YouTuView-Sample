import UIKit
import SnapKit

final class SuggestCollectionViewCell: UICollectionViewCell {
    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) { fatalError() }

    private var suggestView: SuggestView?

    func setup(info: VideoInfo) {
        let suggestView = SuggestView(info: info)

        self.contentView.addSubview(suggestView)

        suggestView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.suggestView = suggestView
    }
}
