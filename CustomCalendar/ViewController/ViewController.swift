//
//  ViewController.swift
//  CustomCalendar
//
//  Created by juntaek.oh on 2022/05/29.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var weekStackView = UIStackView()
    private lazy var calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.getCollectionViewLayout())

    let calendarManager = CalendarManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setViews()
    }
}

private extension ViewController {
    
    func getCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            return CalendarCollectionLayout().create()
        }
    }
    
    func setViews() {
        self.configureWeekStackView()
        self.configureCalendarCollectionView()
    }
    
    func configureWeekStackView() {
        self.view.addSubview(weekStackView)
        self.weekStackView.distribution = .fillEqually
        
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32),
            self.weekStackView.heightAnchor.constraint(equalToConstant: 24),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.configureWeekLabel()
    }
    
    func configureWeekLabel() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        
        dayOfTheWeek.forEach {
            let label = UILabel()
            label.text = $0
            label.textAlignment = .center
            self.weekStackView.addArrangedSubview(label)
            
            if $0 == "일" {
                label.textColor = .systemRed
            } else {
                label.textColor = .systemBlue
            }
        }
    }
    
    func configureCalendarCollectionView() {
        self.view.addSubview(calendarCollectionView)
        self.calendarCollectionView.dataSource = self
        self.calendarCollectionView.delegate = self
        self.calendarCollectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        self.calendarCollectionView.register(CalendarCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalendarCollectionHeader.identifier)
        
        self.calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.calendarCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.calendarCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.calendarCollectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor),
            self.calendarCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.calendarManager.yearMonths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.calendarManager.monthDays[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configureLabel(text: self.calendarManager.monthDays[indexPath.section][indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarCollectionHeader.identifier, for: indexPath) as? CalendarCollectionHeader else { return UICollectionReusableView() }
        
        headerView.setHeaderText(text: self.calendarManager.getMonthsToString(section: indexPath.section))
        
        return headerView
    }
}
