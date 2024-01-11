//
//  StepsSettingsSheet.swift
//  InfiniLink
//
//  Created by Alex Emry on 11/11/21.
//  
//
    

import SwiftUI

struct StepSettingsSheet: View {
	@State var pickerState = 0
	
	var body: some View {
		VStack(alignment: .leading) {
            VStack {
                HStack {
                    Text(NSLocalizedString("steps_settings", comment: ""))
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    SheetCloseButton()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Picker("", selection: $pickerState) {
                    Text(NSLocalizedString("step_goal", comment: "")).tag(0)
                    Text(NSLocalizedString("add_steps", comment: "")).tag(1)
                }
                .pickerStyle(.segmented)
            }
            .padding()
            Divider()
			switch pickerState {
			case 0:
				StepSettingsSheetGoalChange()
			case 1:
				StepSettingsSheetDatePicker()
			default:
				EmptyView()
			}
			Spacer()
		}
	}
}

class NumbersOnly: ObservableObject {
	@Published var value = "" {
		didSet {
			let filtered = value.filter { $0.isNumber }
			
			if value != filtered {
				value = filtered
			}
		}
	}
}

#Preview {
    StepSettingsSheet()
}
