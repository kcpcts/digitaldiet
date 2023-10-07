

struct Progress : Identifiable {
    var id = UUID()
    var date : String
    var total_time : Int
    var dmi : String
    var mode: String
}


import SwiftUI
import Charts
import Firebase


struct BarChartView: View {
    
    //    @State var data = SalesData.last30Days
    
    @State private var threshold = 150.0
    @State var belowColor: Color = .blue
    @State var aboveColor: Color = .orange
    var isOverview: Bool
    
    @State var progressNew : [Progress] = []
    
    @State private var dailyProgress: [DailyProgress] = []
    @State private var loadingError: Error?
    
    var body: some View {
        ScrollView(showsIndicators:false) {
            ZStack {
                Color.gray.brightness(0.4)
                VStack (spacing: 20){
                    Spacer()
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(UserModelManager.shared.getUserModel()?.name ?? "-")
                        .font(.title3)
                    HStack{
                        Text("Today")
                        Text(formatDate(date: Date()))
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .padding(.horizontal,20)
                            .frame(height: 240)
                        VStack(alignment: .leading) {
                            HStack {
                                Image(uiImage: UIImage(named: "SN")!)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("Total Screen time (hours)")
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 5)
                            }.padding(10)
                            chart // Your chart view
                            Text("Weeks: \(calculateUpdatedWeeks())")
                                .font(.subheadline)
                                .padding(10) // Add padding to adjust the spacing
                        }
                        .padding()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .padding(.horizontal,20)
                            .frame(height: 240)
                        VStack(alignment: .leading) {
                            HStack {
                                Image(uiImage: UIImage(named: "SN")!)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("Screen Time Balance")
                                //                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 5)
                            }.padding(10)
                            chartN // Your chart view
                            Text("Weeks: \(calculateUpdatedWeeks())")
                                .font(.subheadline)
                                .padding(10) // Add padding to adjust the spacing
                        }
                        .padding()
                        
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .padding(.horizontal,20)
                            .frame(height: 200)
                        VStack(alignment: .leading) {
                            HStack {
                                Image(uiImage: UIImage(named: "SN")!)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("Emotional Trend")
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 5)
                            }
                            chartNew // Your chart view
                        }
                        .padding()
                        
                    }
                    Spacer()
                }
                
            }.onAppear {
                // Call the fetchDailyProgress function here
                DataService().fetchDailyProgress(userID: Auth.auth().currentUser?.uid ?? "") { progress, error in
                    self.progressNew.removeAll()
                    if let progress = progress {
                        
                        for number in progress {
                            print("Number is \(number)")
                            
                            // Create a Calendar instance
                            let calendar = Calendar.current
                            let dayComponent = calendar.component(.day, from: number.date!)
                            
                            var new  = Progress(date: "\(dayComponent)", total_time: Int(number.total_screen_time!) ?? 0,dmi: number.dmi ?? "-", mode : number.mode ?? "-")
                            self.progressNew.append(new)
                            
                        }
                    } else if let error = error {
                        self.loadingError = error
                    }
                }
            }
        }
        
    }
    
    // A function to calculate and return updated week values
    func calculateUpdatedWeeks() -> Int {
        if progressNew.count < 7 {
            return 1
        } else {
            return progressNew.count / 7
        }
    }
    
    // Function to format a date to a string
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        //           dateFormatter.dateFormat = "EEEE, MMM d, yyyy" // Customize the date format as needed
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    
    private var chart: some View {
        Chart{
            RuleMark(y: .value("Goal",4))
            ForEach(progressNew) { item in
                let belowGoal = item.total_time < 4 // Change 4 to your actual goal value
                let foregroundStyle = belowGoal ? Color.green.gradient : Color.yellow.gradient
                
                BarMark(x: .value("Day", item.date), y: .value("Value", item.total_time)).foregroundStyle(foregroundStyle)
            }
        }.frame(width:300, height:120).foregroundStyle(Color.gray.gradient).chartXAxis(.hidden)
        
    }
    
    private var chartN: some View {
        Chart{
            //            RuleMark(y: .value("Goal",10))
            RuleMark(y: .value("Goal",18))
            RuleMark(y: .value("Goal",28))
            ForEach(progressNew) { item in
                
                let foregroundStyle = calculateForegroundStyle(totalTime: Int(item.dmi) ?? 0)
                
                BarMark(x: .value("Day", item.date), y: .value("Value", Int(item.dmi) ?? 0)).foregroundStyle(foregroundStyle)
            }
        }.frame(width:300, height:120).foregroundStyle(Color.gray.gradient).chartXAxis(.hidden)
        
        
    }
    
    private func calculateForegroundStyle(totalTime: Int) -> AnyGradient {
        let foregroundStyle: AnyGradient
        
        if totalTime <= 18 {
            print("Total time \(totalTime) First")
            foregroundStyle = Color.yellow.gradient
        } else if totalTime <= 28 {
            print("Total time \(totalTime) Second")
            foregroundStyle = Color.green.gradient
        } else {
            foregroundStyle = Color.red.gradient
        }
        
        return foregroundStyle
    }
    
    
    private var chartNew: some View {
        Chart{
            //            RuleMark(y: .value("Goal",10))
            RuleMark(y: .value("Goal",0))
            ForEach(progressNew) { item in
                
                //                BarMark(x: .value("Day", item.date), y: .value("Value", Int(item.dmi)!)).foregroundStyle(Color.green.gradient)
                PointMark(
                    x: .value(
                        "Date", item.date
                    ),
                    y: .value(
                        "Avg Daytime Temperature",
                        Int(item.mode) ?? 0
                    )
                ).foregroundStyle(Color.purple)
            }
        }.frame(width:300, height:120).foregroundStyle(Color.gray.gradient)
            .chartXAxis(.hidden)
        
        
    }
    
    
    
    
}

//#Preview {
//    BarChartView(isOverview: true)
//}
