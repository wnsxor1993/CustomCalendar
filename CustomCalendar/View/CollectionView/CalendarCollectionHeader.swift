//
//  CalendarCollectionHeader.swift
//  CustomCalendar
//
//  Created by juntaek.oh on 2022/06/08.
//

import UIKit

final class CalendarCollectionHeader: UICollectionReusableView {

    static let identifier = "HeaderView"

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setHeaderText(text: nil)
    }

    func setHeaderText(text: String?) {
        label.text = text
    }
}

private extension CalendarCollectionHeader {

    func setLayout() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
