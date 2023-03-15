UNUserNotificationCenter.current().delegate = self
UNUserNotificationCenter.current().requestAuthorization(: [.alert, .badge, .sound], completionHandler: {_, _ in })
application.registerForRemoteNotifications()

let CUSTOM_ACTION1 = UNNotificationAction(identifier: "view_now", title: "CUSTOM_ACTION_TITLE", options: .foreground)

let CUSTOM_ACTION2 = UNNotificationAction(identifier: "skip", title: "CUSTOM_ACTION2_TITLE", options: .foreground)

let CUSTOM_CATEGORY = UNNotificationCategory(identifier: " CUSTOM_CATEGORY_NAME", actions: [CUSTOM_ACTION1, CUSTOM_ACTION2], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)

let notificationCenter = UNUserNotificationCenter.current()
notificationCenter.setNotificationCategories([CUSTOM_CATEGORY])
        
Appoxee.shared()?.saveUserNotificationCategory([CUSTOM_CATEGORY])
