import SwiftUI

enum AppRoute: Hashable {
    case insight(String)
    case subscription
    case catalog(String?)
    case product(String)
    case goal(String)
    case trackingHistory
    case log(String)
    case moodNote
    case editProfile
    case editGoals
    case preference(ProfilePreference)
    case privacy
    case help
    case contact
}

enum ProfilePreference: String, Hashable {
    case dietary = "Dietary preferences"
    case reminders = "Reminders"
    case connectedApps = "Connected apps"
}

struct AppRouteView: View {
    let route: AppRoute

    @ViewBuilder
    var body: some View {
        switch route {
        case .insight(let title):
            InsightDetailPage(title: title)
        case .subscription:
            SubscriptionPage()
        case .catalog(let goal):
            ProductCatalogPage(goal: goal)
        case .product(let name):
            ProductDetailPage(name: name)
        case .goal(let name):
            GoalDetailPage(name: name)
        case .trackingHistory:
            TrackingHistoryPage()
        case .log(let kind):
            LogEntryPage(kind: kind)
        case .moodNote:
            MoodNotePage()
        case .editProfile:
            EditProfilePage()
        case .editGoals:
            EditGoalsPage()
        case .preference(let preference):
            PreferencePage(preference: preference)
        case .privacy:
            PrivacyPage()
        case .help:
            HelpCenterPage()
        case .contact:
            ContactSupportPage()
        }
    }
}

struct RiadDestinationPage<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .padding(.bottom, 32)
        }
        .background(Color.creamBackground.ignoresSafeArea())
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .tint(Color.primaryGreen)
    }
}

struct RiadPrimaryButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: icon)
                .font(.appSans(size: 16, weight: .semibold))
                .foregroundStyle(Color.appWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.primaryGreen, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(RiadPressStyle())
    }
}

struct RiadSavedBanner: View {
    let text: String

    var body: some View {
        Label(text, systemImage: "checkmark.circle.fill")
            .font(.appSans(size: 14, weight: .semibold))
            .foregroundStyle(Color.primaryGreen)
            .frame(maxWidth: .infinity)
            .padding(14)
            .background(Color.paleSage.opacity(0.75), in: RoundedRectangle(cornerRadius: 12))
            .transition(.move(edge: .top).combined(with: .opacity))
    }
}

struct InsightDetailPage: View {
    let title: String
    @State private var addedToGoals = false

    var body: some View {
        RiadDestinationPage(title: title) {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 10) {
                    Image("molecule")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)

                    Text(title)
                        .font(.appSerif(size: 34))
                        .foregroundStyle(Color.darkText)

                    Text("Your recent check-ins suggest that consistency is supporting steadier energy and digestive comfort.")
                        .font(.appSans(size: 17))
                        .foregroundStyle(Color.mutedText)
                        .lineSpacing(4)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("What changed")
                        .font(.appSerif(size: 24))
                        .foregroundStyle(Color.darkText)

                    DetailMetricRow(label: "Fiber consistency", value: "+12%", icon: "leaf")
                    Divider()
                    DetailMetricRow(label: "Energy check-ins", value: "+18%", icon: "bolt")
                    Divider()
                    DetailMetricRow(label: "Digestive comfort", value: "Improving", icon: "waveform.path.ecg")
                }
                .padding(18)
                .riadCard()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Try next")
                        .font(.appSerif(size: 24))
                        .foregroundStyle(Color.darkText)

                    Label("Keep your morning routine within the same two-hour window.", systemImage: "clock")
                    Label("Add one fiber-rich food to tomorrow’s lunch.", systemImage: "leaf")
                    Label("Check in after dinner to compare comfort.", systemImage: "checkmark.circle")
                }
                .font(.appSans(size: 16))
                .foregroundStyle(Color.darkText)

                if addedToGoals {
                    RiadSavedBanner(text: "Added to your goals")
                }

                RiadPrimaryButton(
                    title: addedToGoals ? "Added to goals" : "Add to my goals",
                    icon: addedToGoals ? "checkmark" : "plus"
                ) {
                    withAnimation(RiadMotion.state) { addedToGoals = true }
                }
            }
        }
    }
}

struct DetailMetricRow: View {
    let label: String
    let value: String
    let icon: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(Color.primaryGreen)
                .frame(width: 38, height: 38)
                .background(Color.paleSage.opacity(0.7), in: Circle())
            Text(label)
                .font(.appSans(size: 16, weight: .medium))
                .foregroundStyle(Color.darkText)
            Spacer()
            Text(value)
                .font(.appSans(size: 16, weight: .semibold))
                .foregroundStyle(Color.primaryGreen)
        }
    }
}

struct SubscriptionPage: View {
    @State private var autoRenew = true
    @State private var frequency = "Every 30 days"
    @State private var deliveryDate = Date().addingTimeInterval(60 * 60 * 24 * 5)
    @State private var saved = false

    var body: some View {
        RiadDestinationPage(title: "Manage plan") {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 18) {
                    Image("pill_box_3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Daily Synbiotic")
                            .font(.appSerif(size: 26))
                            .foregroundStyle(Color.darkText)
                        Text("$49 · \(frequency)")
                            .font(.appSans(size: 15))
                            .foregroundStyle(Color.mutedText)
                        Label("Active", systemImage: "checkmark.circle.fill")
                            .font(.appSans(size: 14, weight: .semibold))
                            .foregroundStyle(Color.primaryGreen)
                    }
                }

                VStack(spacing: 0) {
                    Toggle("Auto-renew plan", isOn: $autoRenew)
                        .padding(16)
                    Divider()
                    Picker("Delivery frequency", selection: $frequency) {
                        Text("Every 30 days").tag("Every 30 days")
                        Text("Every 45 days").tag("Every 45 days")
                        Text("Every 60 days").tag("Every 60 days")
                    }
                    .padding(16)
                    Divider()
                    DatePicker("Next delivery", selection: $deliveryDate, displayedComponents: .date)
                        .padding(16)
                }
                .font(.appSans(size: 16))
                .riadCard()

                NavigationLink(value: AppRoute.trackingHistory) {
                    Label("View shipment history", systemImage: "shippingbox")
                        .font(.appSans(size: 16, weight: .medium))
                        .foregroundStyle(Color.darkText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(18)
                        .riadCard()
                }
                .buttonStyle(RiadPressStyle())

                if saved { RiadSavedBanner(text: "Plan changes saved") }
                RiadPrimaryButton(title: "Save plan", icon: "checkmark") {
                    withAnimation(RiadMotion.state) { saved = true }
                }
            }
        }
    }
}

struct ProductCatalogPage: View {
    let goal: String?
    @State private var searchText = ""

    private let products = [
        ("Daily Synbiotic", "Daily gut & immune balance", "$49", "img1"),
        ("Fiber + Prebiotic", "Regularity & digestive comfort", "$39", "img2"),
        ("Travel Pack", "Consistency wherever you go", "$19", "img3"),
        ("Pediatric Synbiotic", "A gentle daily routine", "$42", "img4")
    ]

    var filteredProducts: [(String, String, String, String)] {
        guard !searchText.isEmpty else { return products }
        return products.filter { $0.0.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        RiadDestinationPage(title: goal ?? "All products") {
            LazyVStack(spacing: 14) {
                if let goal {
                    Text("Products selected for \(goal.lowercased())")
                        .font(.appSans(size: 16))
                        .foregroundStyle(Color.mutedText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                ForEach(filteredProducts, id: \.0) { product in
                    NavigationLink(value: AppRoute.product(product.0)) {
                        HStack(spacing: 16) {
                            Image(product.3)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 96, height: 96)
                            VStack(alignment: .leading, spacing: 6) {
                                Text(product.0)
                                    .font(.appSerif(size: 21))
                                    .foregroundStyle(Color.darkText)
                                Text(product.1)
                                    .font(.appSans(size: 14))
                                    .foregroundStyle(Color.mutedText)
                                Text(product.2)
                                    .font(.appSans(size: 17, weight: .bold))
                                    .foregroundStyle(Color.primaryGreen)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.primaryGreen)
                        }
                        .padding(14)
                        .riadCard()
                    }
                    .buttonStyle(RiadPressStyle())
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search products")
    }
}

struct ProductDetailPage: View {
    let name: String
    @State private var quantity = 1
    @State private var purchaseMode = "Subscribe"
    @State private var added = false

    private var imageName: String {
        if name.contains("Fiber") { return "img2" }
        if name.contains("Travel") { return "img3" }
        if name.contains("Pediatric") { return "img4" }
        return "img1"
    }

    var body: some View {
        RiadDestinationPage(title: "Product details") {
            VStack(alignment: .leading, spacing: 20) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)

                Text(name)
                    .font(.appSerif(size: 34))
                    .foregroundStyle(Color.darkText)
                Text("Designed to fit a simple daily routine with clear instructions and flexible delivery.")
                    .font(.appSans(size: 17))
                    .foregroundStyle(Color.mutedText)
                    .lineSpacing(4)

                Picker("Purchase", selection: $purchaseMode) {
                    Text("Subscribe").tag("Subscribe")
                    Text("One-time").tag("One-time")
                }
                .pickerStyle(.segmented)

                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...6)
                    .font(.appSans(size: 16, weight: .medium))
                    .padding(16)
                    .riadCard()

                VStack(alignment: .leading, spacing: 12) {
                    Label("Simple once-daily routine", systemImage: "sun.max")
                    Label("Flexible delivery schedule", systemImage: "calendar")
                    Label("Pause or skip from your plan", systemImage: "pause.circle")
                }
                .font(.appSans(size: 16))
                .foregroundStyle(Color.darkText)

                if added { RiadSavedBanner(text: "\(name) added to your routine") }
                RiadPrimaryButton(title: added ? "Added to routine" : "Add to routine", icon: added ? "checkmark" : "plus") {
                    withAnimation(RiadMotion.state) { added = true }
                }
            }
        }
    }
}

struct GoalDetailPage: View {
    let name: String
    @State private var target = 5
    @State private var saved = false

    var body: some View {
        RiadDestinationPage(title: name) {
            VStack(alignment: .leading, spacing: 22) {
                Text("Build a rhythm that works")
                    .font(.appSerif(size: 32))
                    .foregroundStyle(Color.darkText)
                Text("Choose a weekly target and use quick logs to keep your progress current.")
                    .font(.appSans(size: 17))
                    .foregroundStyle(Color.mutedText)

                HStack(spacing: 18) {
                    MiniProgressRing(progress: 0.72, isText: true)
                        .scaleEffect(1.35)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Current week")
                            .font(.appSans(size: 14))
                            .foregroundStyle(Color.mutedText)
                        Text("4 of \(target) days")
                            .font(.appSerif(size: 28))
                            .foregroundStyle(Color.primaryGreen)
                    }
                }
                .padding(22)
                .riadCard()

                Stepper("Weekly target: \(target) days", value: $target, in: 1...7)
                    .font(.appSans(size: 16, weight: .medium))
                    .padding(16)
                    .riadCard()

                NavigationLink(value: AppRoute.log(name)) {
                    Label("Log progress", systemImage: "plus.circle.fill")
                        .font(.appSans(size: 16, weight: .semibold))
                        .foregroundStyle(Color.primaryGreen)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(18)
                        .riadCard()
                }
                .buttonStyle(RiadPressStyle())

                if saved { RiadSavedBanner(text: "Goal target updated") }
                RiadPrimaryButton(title: "Save goal", icon: "checkmark") {
                    withAnimation(RiadMotion.state) { saved = true }
                }
            }
        }
    }
}

struct TrackingHistoryPage: View {
    @State private var range = "7 days"
    private let entries = [
        ("Today", "Morning synbiotic", "Completed"),
        ("Yesterday", "Fiber", "28 g"),
        ("Yesterday", "Water", "2.4 L"),
        ("May 12", "Digestive comfort", "Good"),
        ("May 11", "Movement", "32 min")
    ]

    var body: some View {
        RiadDestinationPage(title: "History") {
            VStack(spacing: 18) {
                Picker("Range", selection: $range) {
                    Text("7 days").tag("7 days")
                    Text("30 days").tag("30 days")
                    Text("90 days").tag("90 days")
                }
                .pickerStyle(.segmented)

                VStack(spacing: 0) {
                    ForEach(entries, id: \.1) { entry in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.1)
                                    .font(.appSans(size: 16, weight: .medium))
                                    .foregroundStyle(Color.darkText)
                                Text(entry.0)
                                    .font(.appSans(size: 13))
                                    .foregroundStyle(Color.mutedText)
                            }
                            Spacer()
                            Text(entry.2)
                                .font(.appSans(size: 15, weight: .semibold))
                                .foregroundStyle(Color.primaryGreen)
                        }
                        .padding(16)
                        if entry.1 != entries.last?.1 { Divider().padding(.leading, 16) }
                    }
                }
                .riadCard()
            }
        }
    }
}

struct LogEntryPage: View {
    let kind: String
    @State private var date = Date()
    @State private var amount = 1.0
    @State private var note = ""
    @State private var saved = false

    var body: some View {
        Form {
            Section {
                DatePicker("When", selection: $date)
                Stepper(value: $amount, in: 0...20, step: 0.5) {
                    Text("Amount: \(amount, specifier: "%.1f")")
                }
            } header: {
                Text(kind)
            }

            Section("Notes") {
                TextField("Optional context", text: $note, axis: .vertical)
                    .lineLimit(3...6)
            }

            Section {
                Button {
                    withAnimation(RiadMotion.state) { saved = true }
                } label: {
                    Label(saved ? "Entry saved" : "Save entry", systemImage: saved ? "checkmark.circle.fill" : "plus.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .foregroundStyle(Color.primaryGreen)
            }
        }
        .navigationTitle("Log \(kind.lowercased())")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.creamBackground)
        .tint(Color.primaryGreen)
    }
}

struct MoodNotePage: View {
    @State private var mood = "Good"
    @State private var note = ""
    @State private var saved = false

    var body: some View {
        Form {
            Section("How are you feeling?") {
                Picker("Mood", selection: $mood) {
                    ForEach(["Very low", "Low", "Neutral", "Good", "Great"], id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
            }
            Section("Add context") {
                TextEditor(text: $note)
                    .frame(minHeight: 140)
            }
            Section {
                Button(saved ? "Note saved" : "Save note") {
                    withAnimation(RiadMotion.state) { saved = true }
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.primaryGreen)
            }
        }
        .navigationTitle("Mood note")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.creamBackground)
        .tint(Color.primaryGreen)
    }
}

struct EditProfilePage: View {
    @State private var name = "Adil Kettani"
    @State private var email = "adil@example.com"
    @State private var birthDate = Calendar.current.date(byAdding: .year, value: -32, to: Date()) ?? Date()
    @State private var saved = false

    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Image("pfp")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 112, height: 112)
                        .clipShape(Circle())
                    Spacer()
                }
            }
            Section("Personal details") {
                TextField("Full name", text: $name)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                DatePicker("Date of birth", selection: $birthDate, displayedComponents: .date)
            }
            Section {
                Button(saved ? "Profile saved" : "Save changes") {
                    withAnimation(RiadMotion.state) { saved = true }
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.primaryGreen)
            }
        }
        .navigationTitle("Edit profile")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.creamBackground)
        .tint(Color.primaryGreen)
    }
}

struct EditGoalsPage: View {
    @State private var selected: Set<String> = ["Daily balance", "Better digestion"]
    private let goals = ["Daily balance", "Better digestion", "More energy", "Regularity", "Immune support", "On-the-go consistency"]

    var body: some View {
        List {
            Section("Choose your priorities") {
                ForEach(goals, id: \.self) { goal in
                    Button {
                        if selected.contains(goal) { selected.remove(goal) } else { selected.insert(goal) }
                    } label: {
                        HStack {
                            Text(goal)
                                .foregroundStyle(Color.darkText)
                            Spacer()
                            if selected.contains(goal) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.primaryGreen)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit goals")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.creamBackground)
        .tint(Color.primaryGreen)
    }
}

struct PreferencePage: View {
    let preference: ProfilePreference
    @State private var vegetarian = true
    @State private var dairyFree = false
    @State private var reminderTime = Calendar.current.date(from: DateComponents(hour: 8)) ?? Date()
    @State private var appleHealth = true

    var body: some View {
        Form {
            switch preference {
            case .dietary:
                Section("Eating preferences") {
                    Toggle("Vegetarian", isOn: $vegetarian)
                    Toggle("Dairy-free", isOn: $dairyFree)
                    Toggle("Gluten-free", isOn: .constant(false))
                }
            case .reminders:
                Section("Daily routine") {
                    Toggle("Routine reminder", isOn: .constant(true))
                    DatePicker("Reminder time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                }
            case .connectedApps:
                Section("Health data") {
                    Toggle("Apple Health", isOn: $appleHealth)
                    LabeledContent("Last sync", value: "Today, 8:14 AM")
                    Button("Sync now") { }
                        .foregroundStyle(Color.primaryGreen)
                }
            }
        }
        .navigationTitle(preference.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.creamBackground)
        .tint(Color.primaryGreen)
    }
}

struct PrivacyPage: View {
    @State private var analytics = true
    @State private var research = false

    var body: some View {
        Form {
            Section("Your controls") {
                Toggle("Product analytics", isOn: $analytics)
                Toggle("Contribute de-identified data", isOn: $research)
            }
            Section("Your data") {
                Button("Download my data") { }
                Button("Review connected data") { }
            }
            Section {
                Text("Health information remains under your control. You can change sharing preferences or request an export at any time.")
                    .font(.appSans(size: 14))
                    .foregroundStyle(Color.mutedText)
            }
        }
        .navigationTitle("Data & privacy")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.creamBackground)
        .tint(Color.primaryGreen)
    }
}

struct HelpCenterPage: View {
    @State private var expanded: String?
    private let questions = [
        ("How do I change my delivery?", "Open Manage plan to change the frequency or next delivery date."),
        ("How should I use daily tracking?", "Log only what is useful to you. Consistent, lightweight check-ins are more valuable than perfect records."),
        ("Can I change my reminders?", "Yes. Open Profile, then Reminders, and choose a time that fits your routine.")
    ]

    var body: some View {
        RiadDestinationPage(title: "Help center") {
            VStack(alignment: .leading, spacing: 18) {
                Text("How can we help?")
                    .font(.appSerif(size: 32))
                    .foregroundStyle(Color.darkText)

                ForEach(questions, id: \.0) { question in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expanded == question.0 },
                            set: { expanded = $0 ? question.0 : nil }
                        )
                    ) {
                        Text(question.1)
                            .font(.appSans(size: 15))
                            .foregroundStyle(Color.mutedText)
                            .padding(.top, 10)
                    } label: {
                        Text(question.0)
                            .font(.appSans(size: 16, weight: .medium))
                            .foregroundStyle(Color.darkText)
                    }
                    .padding(16)
                    .riadCard()
                }

                NavigationLink(value: AppRoute.contact) {
                    Label("Contact support", systemImage: "message")
                        .font(.appSans(size: 16, weight: .semibold))
                        .foregroundStyle(Color.primaryGreen)
                        .frame(maxWidth: .infinity)
                        .padding(18)
                        .riadCard()
                }
                .buttonStyle(RiadPressStyle())
            }
        }
    }
}

struct ContactSupportPage: View {
    @State private var topic = "My plan"
    @State private var message = ""
    @State private var sent = false

    var body: some View {
        Form {
            Section("What do you need help with?") {
                Picker("Topic", selection: $topic) {
                    ForEach(["My plan", "Tracking", "Products", "Account", "Other"], id: \.self) { Text($0) }
                }
                TextField("Tell us what happened", text: $message, axis: .vertical)
                    .lineLimit(5...10)
            }
            Section {
                Button {
                    withAnimation(RiadMotion.state) { sent = true }
                } label: {
                    Label(sent ? "Message sent" : "Send message", systemImage: sent ? "checkmark.circle.fill" : "paperplane")
                        .frame(maxWidth: .infinity)
                }
                .foregroundStyle(Color.primaryGreen)
                .disabled(message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            if sent {
                Section {
                    Text("We’ll reply to your account email. This prototype stores the message locally.")
                        .font(.appSans(size: 14))
                        .foregroundStyle(Color.mutedText)
                }
            }
        }
        .navigationTitle("Contact support")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.creamBackground)
        .tint(Color.primaryGreen)
    }
}
