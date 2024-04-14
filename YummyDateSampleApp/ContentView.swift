//
//  ContentView.swift
//  YummyDateSampleApp
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI
import SwiftData  
import YummyDate

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var currentTheme = YummyTheme.limeTheme  
    @StateObject private var dateSelectionManager = DateSelectionManager()
    @State private var selectedDate = Date()

    var body: some View {
        NavigationSplitView {
            YummyDateBar(selectionManager: dateSelectionManager,
                         selectedDate: $selectedDate,
                         onDateTapped: {
                    //DateSelectionManager can be replaced or added to existing logic for date handling (fetching logs with date, refreshing, etc.)
                   //This closes dateselector and goes back to today,extra methods can be added or called here.
            },
                         onCalendarTapped: {},
                         theme: currentTheme
            )
            .padding([.vertical, .horizontal], 4)
            List {
                Section(header: Text("Items")) {
                    ForEach(items.filter { $0.timestamp.isInSameDay(as: selectedDate) }) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Change Theme") {
                        cycleThemes()
                    }
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func cycleThemes() {
        if currentTheme == YummyTheme.limeTheme {
            currentTheme = YummyTheme.sunsetTheme
        } else if currentTheme == YummyTheme.sunsetTheme {
            currentTheme = YummyTheme.oceanTheme
        } else {
            currentTheme = YummyTheme.limeTheme
        }
    }


    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(modelContext.delete)
        }
    }
}

extension Date {
    func isInSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
