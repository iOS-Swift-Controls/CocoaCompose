import Cocoa

public class Checkbox: NSStackView {
    private let button = NSButton()
    private let trailingViews: [NSView]
    
    public var onChange: ((Bool) -> Void)?
    
    public init(title: String = "", on: Bool = false, views: [NSView] = [], onChange: ((Bool) -> Void)? = nil) {
        self.trailingViews = views
        self.onChange = onChange
        
        super.init(frame: .zero)
        self.orientation = .horizontal
        self.alignment = .firstBaseline
        self.spacing = 5
        
        button.setButtonType(.switch)
        button.font = .preferredFont(forTextStyle: .body)
        button.title = title
        button.target = self
        button.action = #selector(buttonAction)
        
        addArrangedSubview(button)
        
        views.forEach { addArrangedSubview($0) }
        
        set(on: on)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(on: Bool) {
        button.state = on ? .on : .off
        trailingViews.forEach { $0.enableSubviews(on) }
    }
    
    // MARK: - Actions
    
    @objc func buttonAction(_ sender: NSButton) {
        trailingViews.forEach { $0.enableSubviews(sender.state == .on) }
        onChange?(sender.state == .on)
    }
}
