class AppRegex {
  static String mobileOrEmail =
      r'(^\d{10}$)|(^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$)';
  static String email = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static String phone = r'^\+?[1-9]\d{1,14}$';
  static String decimalNumber = r'^\d*\.?\d*';
}
