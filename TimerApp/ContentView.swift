//
//  ContentView.swift
//  TimerApp
//
//  Created by Suleman Ali on 24/12/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TimerViewModel
    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
            VStack {
                Text("Timer App").font(.largeTitle)
                Spacer()
                TimerView(progress: viewModel.progress)
                    .padding()
                    .frame(width: 300, height: 300)
                HStack{
                    // MARK: - Start and Pause Button
                    Button(action: {
                        viewModel.isTimerStarted.toggle()
                    }) {
                        Text(viewModel.isTimerStarted ? "Pause" : "Start")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6)
                            .foregroundColor(viewModel.isTimerStarted ?  .red : .white )
                            .font(.system(size: 18).bold())
                            .background(
                                ZStack {
                                    RoundedRectangle(
                                        cornerRadius: 14,
                                        style: .continuous
                                    )
                                    .fill(viewModel.isTimerStarted ?  .clear : .red )
                                    RoundedRectangle(
                                        cornerRadius: 14,
                                        style: .continuous
                                    )
                                    .stroke(.red, lineWidth: 2)
                                }
                            )
                    }
                        // MARK: - Start and Stop Button
                    Button(action: {
                        viewModel.resetView()
                    }) {
                        Text("Stop").padding(.horizontal, 20)
                            .padding(.vertical, 6)
                            .foregroundColor(.white )
                            .font(.system(size: 18).bold())
                            .background(
                                ZStack {
                                    RoundedRectangle(
                                        cornerRadius: 14,
                                        style: .continuous
                                    )
                                    .fill(.red )
                                    RoundedRectangle(
                                        cornerRadius: 14,
                                        style: .continuous
                                    )
                                    .stroke(.red, lineWidth: 2)
                                }
                            )
                    }
                    .padding()
                }
                Spacer()
            }
            .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { (_) in
                if viewModel.selectedTime > 0 && viewModel.isTimerStarted {
                    viewModel.selectedTime -= 0.01
                    if viewModel.selectedTime < 0 {
                        viewModel.selectedTime = 0
                    }
                    withAnimation(.default) {
                        viewModel.progress = viewModel.selectedTime
                    }
                    if viewModel.selectedTime == 0 {
                        viewModel.resetView()
                    }
                }
            }
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (_, _) in
                }
                UNUserNotificationCenter.current().delegate = viewModel
        }
    }
}

#Preview {
    ContentView(viewModel: TimerViewModel())
}
