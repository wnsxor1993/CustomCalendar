//
//  ViewController.swift
//  CustomCalendar
//
//  Created by juntaek.oh on 2022/05/29.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var weekStackView = UIStackView()
    private lazy var yearMonthLabel = UILabel()
    private lazy var calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.getCollectionViewLayout())

    let calendarDateFormatter = CalendarDateFormatter()
    
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
        self.configureYearMonthLabel()
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
    
    func configureYearMonthLabel() {
        self.view.addSubview(yearMonthLabel)
        self.yearMonthLabel.text = self.calendarDateFormatter.getYearMonthText()
        self.yearMonthLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        self.yearMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.yearMonthLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.yearMonthLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.yearMonthLabel.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor, constant: 24),
            self.yearMonthLabel.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    func configureCalendarCollectionView() {
        self.view.addSubview(calendarCollectionView)
        self.calendarCollectionView.dataSource = self
        self.calendarCollectionView.delegate = self
        self.calendarCollectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        
        self.calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.calendarCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.calendarCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.calendarCollectionView.topAnchor.constraint(equalTo: self.yearMonthLabel.bottomAnchor, constant: 16),
            self.calendarCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.calendarDateFormatter.updateCurrentMonthDays().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configureLabel(text: self.calendarDateFormatter.updateCurrentMonthDays()[indexPath.item])
        
        if indexPath.item % 7 == 0 {
            cell.setSundayColor()
        }
        
        return cell
    }
}
