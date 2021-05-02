import UIKit

final class YouTubeLikeAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    /// custom animation occurs only push or pop cases
    init?(operation: UINavigationController.Operation) {
        guard operation == .push || operation == .pop else { return nil }

        self.operation = operation

        super.init()
    }

    let movedDistance: CGFloat = 70.0 // 遷移元のviewのずれる分の距離
    // duration for animation
    let duration = 0.3
    let operation: UINavigationController.Operation

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }

    // set animation for push and pop
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
              let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }

        if operation == .push {
            pushAnimator(transitionContext: transitionContext, toView: toVC.view, fromView: fromVC.view)
        } else if operation == .pop {
            popAnimator(transitionContext: transitionContext, toView: toVC.view, fromView: fromVC.view)
        }
    }

    // MARK: Animator for push navigation
    // FIXME: demo animation
    private func pushAnimator(transitionContext: UIViewControllerContextTransitioning, toView: UIView, fromView: UIView) {
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, aboveSubview: fromView)

        toView.frame = toView.frame.offsetBy(dx: 0, dy: containerView.frame.size.height)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.05, options: .curveEaseInOut, animations: { () -> Void in
            toView.frame = containerView.frame
        }) { (finished) -> Void in
            transitionContext.completeTransition(true)
        }
    }

    // MARK: Animator for pop navigation
    // FIXME: demo animation
    private func popAnimator(transitionContext: UIViewControllerContextTransitioning, toView: UIView, fromView: UIView) {
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, belowSubview: fromView)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.05, options: .curveEaseInOut, animations: { () -> Void in
            fromView.frame = fromView.frame.offsetBy(dx: 0, dy: containerView.frame.size.height)
        }) { (finished) -> Void in
            transitionContext.completeTransition(true)
        }
    }
}
