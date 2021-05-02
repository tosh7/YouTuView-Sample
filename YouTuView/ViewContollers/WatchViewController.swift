import UIKit

final class WatchViewController: UIViewController {

    init(video: VideoInfo) {
        self.video = video
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    private let video: VideoInfo
}

