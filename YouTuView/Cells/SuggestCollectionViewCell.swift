import UIKit
import SnapKit

final class SuggestCollectionViewCell: UICollectionViewListCell {
    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) { fatalError() }

    private var suggestView: SuggestView?
    private var item: Item?

    func setup(info: VideoInfo) {
        let suggestView = SuggestView(info: info)

        self.contentView.addSubview(suggestView)

        suggestView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.suggestView = suggestView
    }

    func updateWithItem(_ newItem: Item) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }
}
