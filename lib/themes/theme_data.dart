part of 'package:halisahaapp/main.dart';

final ThemeData _themeData = ThemeData(
  colorScheme: const ColorScheme(
    primary: ThemeColors.blue,
    secondary: ThemeColors.black,
    surface: ThemeColors.white,
    background: ThemeColors.white,
    error: ThemeColors.blue,
    onPrimary: ThemeColors.white,
    onSecondary: ThemeColors.white,
    onSurface: ThemeColors.black,
    onBackground: ThemeColors.black,
    onError: ThemeColors.white,
    brightness: Brightness.light,
  ),
  brightness: Brightness.light,
  primaryColor: ThemeColors.blue,
  primaryColorLight: ThemeColors.blue,
  primaryColorDark: ThemeColors.blue,
  canvasColor: ThemeColors.white,
  scaffoldBackgroundColor: ThemeColors.offWhite,
  bottomAppBarColor: ThemeColors.white,
  cardColor: ThemeColors.white,
  dividerColor: ThemeColors.grayTertiary,
  highlightColor: const Color(0x40cccccc),
  splashColor: const Color(0x40cccccc),
  selectedRowColor: const Color(0xFFf5f5f5),
  unselectedWidgetColor: const Color(0xb3ffffff),
  disabledColor: const Color(0x62ffffff),
  toggleableActiveColor: ThemeColors.blue,
  secondaryHeaderColor: ThemeColors.white,
  backgroundColor: ThemeColors.white,
  dialogBackgroundColor: ThemeColors.white,
  indicatorColor: ThemeColors.blue,
  hintColor: ThemeColors.graySecondary,
  errorColor: ThemeColors.blue,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      height: 24.0 / 16.0,
    ),
    bodyText2: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      height: 20.0 / 14.0,
    ),
    headline1: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w600,
      fontSize: 48.0,
      height: 56.0 / 48.0,
    ),
    headline2: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 48.0,
      height: 56.0 / 48.0,
    ),
    headline3: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 36.0,
    ),
    headline4: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 24.0,
    ),
    headline5: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 20.0,
      height: 28.0 / 20.0,
    ),
    headline6: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
      height: 24.0 / 18.0,
    ),
    overline: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      letterSpacing: 1.1,
    ),
    caption: TextStyle(
      color: ThemeColors.grayPrimary,
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
      height: 16.0 / 12.0,
    ),
    button: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    ),
    subtitle1: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      height: 24.0 / 16.0,
    ),
    subtitle2: TextStyle(
      color: ThemeColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      height: 20.0 / 14.0,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: ThemeColors.blue,
    foregroundColor: ThemeColors.white,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0.0,
    shadowColor: Colors.transparent,
    centerTitle: true,
    toolbarHeight: AppConstants.toolbarHeight,
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: ThemeColors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: ThemeColors.grayPrimary,
    unselectedItemColor: ThemeColors.grayPrimary,
    selectedIconTheme: IconThemeData(
      size: 24.0,
      color: ThemeColors.blue,
    ),
    unselectedIconTheme: IconThemeData(
      size: 24.0,
      color: ThemeColors.grayPrimary,
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      height: 12.0 / 10.0,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      height: 12.0 / 10.0,
    ),
    backgroundColor: ThemeColors.white,
    elevation: 8.0,
    type: BottomNavigationBarType.fixed,
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: ThemeColors.black,
    labelStyle: TextStyle(
      fontWeight: FontWeight.w500,
    ),
    labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
    unselectedLabelColor: ThemeColors.grayPrimary,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88.0,
    height: AppConstants.heightButton,
    padding: EdgeInsets.symmetric(
      horizontal: 16.0,
    ),
    shape: StadiumBorder(
      side: BorderSide(
        color: ThemeColors.blue,
        width: AppConstants.borderWidth,
        style: BorderStyle.solid,
      ),
    ),
    alignedDropdown: false,
    buttonColor: ThemeColors.blue,
    disabledColor: ThemeColors.grayTertiary,
    highlightColor: Color(0x29ffffff),
    splashColor: Color(0x1fffffff),
    focusColor: Color(0x1fffffff),
    hoverColor: Color(0x0affffff),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: ThemeColors.red,
      alignment: Alignment.center,
      textStyle: const TextStyle(
        color: ThemeColors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(
        color: ThemeColors.blue,
        width: AppConstants.borderWidth,
        style: BorderStyle.none,
      ),
      elevation: 0.0,
      shadowColor: Colors.transparent,
      minimumSize: const Size(0.0, AppConstants.heightButton),
      shape: const StadiumBorder(),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      alignment: Alignment.center,
      textStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(
        color: ThemeColors.blue,
        width: AppConstants.borderWidth,
        style: BorderStyle.solid,
      ),
      backgroundColor: Colors.transparent,
      primary: ThemeColors.blue,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      minimumSize: const Size(0.0, AppConstants.heightButton),
      shape: const StadiumBorder(),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
      foregroundColor: MaterialStateProperty.all(ThemeColors.blue),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
      minimumSize: MaterialStateProperty.all(
        const Size(0.0, AppConstants.heightButton),
      ),
      shape: MaterialStateProperty.all(
        const StadiumBorder(),
      ),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: ThemeColors.grayPrimary,
      letterSpacing: 1.1,
    ),
    helperStyle: TextStyle(
      color: ThemeColors.grayPrimary,
    ),
    hintStyle: TextStyle(
      color: ThemeColors.graySecondary,
      fontWeight: FontWeight.w400,
    ),
    errorStyle: TextStyle(
      color: ThemeColors.blue,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    contentPadding: EdgeInsets.symmetric(
      vertical: 4.0,
    ),
    isCollapsed: false,
    filled: false,
    fillColor: Colors.transparent,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    alignLabelWithHint: true,
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ThemeColors.blue,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ThemeColors.grayPrimary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ThemeColors.blue,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ThemeColors.grayPrimary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ThemeColors.grayPrimary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ThemeColors.grayPrimary,
        width: 1.0,
        style: BorderStyle.none,
      ),
    ),
    suffixIconColor: ThemeColors.black,
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(ThemeColors.black),
    fillColor: MaterialStateProperty.all(ThemeColors.black),
    side: const BorderSide(
      color: ThemeColors.graySecondary,
      width: AppConstants.borderWidth,
      style: BorderStyle.solid,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
    ),
  ),
  sliderTheme: const SliderThemeData(
    activeTrackColor: null,
    inactiveTrackColor: null,
    disabledActiveTrackColor: null,
    disabledInactiveTrackColor: null,
    activeTickMarkColor: null,
    inactiveTickMarkColor: null,
    disabledActiveTickMarkColor: null,
    disabledInactiveTickMarkColor: null,
    thumbColor: null,
    disabledThumbColor: null,
    thumbShape: RoundSliderThumbShape(),
    overlayColor: null,
    valueIndicatorColor: null,
    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
    showValueIndicator: ShowValueIndicator.onlyForContinuous,
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: ThemeColors.red,
    brightness: Brightness.dark,
    deleteIconColor: ThemeColors.white,
    disabledColor: ThemeColors.grayTertiary,
    labelPadding: EdgeInsets.symmetric(
      horizontal: 12.0,
    ),
    labelStyle: TextStyle(
      color: ThemeColors.white,
    ),
    padding: EdgeInsets.all(4.0),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3dffffff),
    ),
    secondarySelectedColor: Color(0x3d212121),
    selectedColor: Color(0x3dffffff),
    shape: StadiumBorder(
      side: BorderSide(
        color: Colors.transparent,
        width: 0.0,
        style: BorderStyle.none,
      ),
    ),
  ),
  cardTheme: const CardTheme(
    shadowColor: Color(0x99000000),
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          8.0,
        ),
      ),
    ),
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.transparent,
        width: 0.0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          8.0,
        ),
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          8.0,
        ),
      ),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: ThemeColors.blue,
  ),
  dividerTheme: const DividerThemeData(
    color: ThemeColors.grayTertiary,
    thickness: 1.0,
    space: 24.0,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: ThemeColors.blue,
    // selectionColor: ThemeColors.teal.shade300,
    // selectionHandleColor: ThemeColors.teal,
  ),
);
/////////////////////////////////////////////////////////////
///DarkTheme
//////////////////////////////////////////////////////////////
ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    colorScheme: ColorScheme(
      primary: ThemeColors.blue.shade800,
      secondary: ThemeColors.white,
      surface: ThemeColors.black,
      background: ThemeColors.gray.shade800,
      error: ThemeColors.blue,
      onPrimary: ThemeColors.black,
      onSecondary: ThemeColors.black,
      onSurface: ThemeColors.black,
      onBackground: ThemeColors.black,
      onError: ThemeColors.white,
      brightness: Brightness.light,
    ),
    brightness: Brightness.light,
    primaryColor: ThemeColors.blue.shade800,
    primaryColorLight: ThemeColors.blue.shade800,
    primaryColorDark: ThemeColors.blue.shade800,
    canvasColor: ThemeColors.gray.shade800,
    scaffoldBackgroundColor: ThemeColors.gray.shade800,
    bottomAppBarColor: ThemeColors.gray.shade800,
    cardColor: ThemeColors.gray.shade800,
    dividerColor: ThemeColors.grayTertiary,
    highlightColor: const Color(0x40cccccc),
    splashColor: const Color(0x40cccccc),
    selectedRowColor: const Color(0xFFf5f5f5),
    unselectedWidgetColor: const Color(0xb3ffffff),
    disabledColor: const Color(0x62ffffff),
    toggleableActiveColor: ThemeColors.blue.shade800,
    secondaryHeaderColor: ThemeColors.black,
    backgroundColor: ThemeColors.black,
    dialogBackgroundColor: ThemeColors.black,
    indicatorColor: ThemeColors.blue.shade800,
    hintColor: ThemeColors.offWhite,
    errorColor: ThemeColors.blue.shade800,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: ThemeColors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
        height: 24.0 / 16.0,
      ),
      bodyText2: TextStyle(
        color: ThemeColors.grayPrimary,
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        height: 20.0 / 14.0,
      ),
      headline1: TextStyle(
        color: ThemeColors.grayPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 48.0,
        height: 56.0 / 48.0,
      ),
      headline2: TextStyle(
        color: ThemeColors.grayPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 48.0,
        height: 56.0 / 48.0,
      ),
      headline3: TextStyle(
        color: ThemeColors.grayPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 36.0,
      ),
      headline4: TextStyle(
        color: ThemeColors.grayPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      ),
      headline5: TextStyle(
        color: ThemeColors.grayPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        height: 28.0 / 20.0,
      ),
      headline6: TextStyle(
        color: ThemeColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        height: 24.0 / 18.0,
      ),
      overline: TextStyle(
        color: ThemeColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
        letterSpacing: 1.1,
      ),
      caption: TextStyle(
        color: ThemeColors.grayPrimary,
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        height: 16.0 / 12.0,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      ),
      subtitle1: TextStyle(
        color: ThemeColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        height: 24.0 / 16.0,
      ),
      subtitle2: TextStyle(
        color: ThemeColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        height: 20.0 / 14.0,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.blue,
      foregroundColor: ThemeColors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      centerTitle: true,
      toolbarHeight: AppConstants.toolbarHeight,
      titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ThemeColors.white,
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ThemeColors.grayPrimary,
      unselectedItemColor: ThemeColors.grayPrimary,
      selectedIconTheme: IconThemeData(
        size: 24.0,
        color: ThemeColors.blue,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24.0,
        color: ThemeColors.grayPrimary,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
        height: 12.0 / 10.0,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
        height: 12.0 / 10.0,
      ),
      backgroundColor: ThemeColors.white,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: ThemeColors.white,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
      unselectedLabelColor: ThemeColors.grayPrimary,
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      minWidth: 88.0,
      height: AppConstants.heightButton,
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: ThemeColors.blue,
          width: AppConstants.borderWidth,
          style: BorderStyle.solid,
        ),
      ),
      alignedDropdown: false,
      buttonColor: ThemeColors.blue,
      disabledColor: ThemeColors.grayTertiary,
      highlightColor: Color(0x29ffffff),
      splashColor: Color(0x1fffffff),
      focusColor: Color(0x1fffffff),
      hoverColor: Color(0x0affffff),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ThemeColors.red,
        alignment: Alignment.center,
        textStyle: const TextStyle(
          color: ThemeColors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        side: const BorderSide(
          color: ThemeColors.blue,
          width: AppConstants.borderWidth,
          style: BorderStyle.none,
        ),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(0.0, AppConstants.heightButton),
        shape: const StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        alignment: Alignment.center,
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        side: const BorderSide(
          color: ThemeColors.blue,
          width: AppConstants.borderWidth,
          style: BorderStyle.solid,
        ),
        backgroundColor: Colors.transparent,
        primary: ThemeColors.blue,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(0.0, AppConstants.heightButton),
        shape: const StadiumBorder(),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        foregroundColor: MaterialStateProperty.all(ThemeColors.blue),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size(0.0, AppConstants.heightButton),
        ),
        shape: MaterialStateProperty.all(
          const StadiumBorder(),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: ThemeColors.grayPrimary,
        letterSpacing: 1.1,
      ),
      helperStyle: TextStyle(
        color: ThemeColors.grayPrimary,
      ),
      hintStyle: TextStyle(
        color: ThemeColors.graySecondary,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: TextStyle(
        color: ThemeColors.blue,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorMaxLines: null,
      isDense: false,
      contentPadding: EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      isCollapsed: false,
      filled: false,
      fillColor: Colors.transparent,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      alignLabelWithHint: true,
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColors.blue,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColors.grayPrimary,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColors.blue,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColors.grayPrimary,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColors.grayPrimary,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColors.grayPrimary,
          width: 1.0,
          style: BorderStyle.none,
        ),
      ),
      suffixIconColor: ThemeColors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(ThemeColors.white),
      fillColor: MaterialStateProperty.all(ThemeColors.white),
      side: const BorderSide(
        color: ThemeColors.graySecondary,
        width: AppConstants.borderWidth,
        style: BorderStyle.solid,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: null,
      inactiveTrackColor: null,
      disabledActiveTrackColor: null,
      disabledInactiveTrackColor: null,
      activeTickMarkColor: null,
      inactiveTickMarkColor: null,
      disabledActiveTickMarkColor: null,
      disabledInactiveTickMarkColor: null,
      thumbColor: null,
      disabledThumbColor: null,
      thumbShape: RoundSliderThumbShape(),
      overlayColor: null,
      valueIndicatorColor: null,
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.onlyForContinuous,
      valueIndicatorTextStyle: TextStyle(
        color: ThemeColors.white,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: ThemeColors.red,
      brightness: Brightness.dark,
      deleteIconColor: ThemeColors.white,
      disabledColor: ThemeColors.grayTertiary,
      labelPadding: EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      labelStyle: TextStyle(
        color: ThemeColors.white,
      ),
      padding: EdgeInsets.all(4.0),
      secondaryLabelStyle: TextStyle(
        color: Color(0x3dffffff),
      ),
      secondarySelectedColor: Color(0x3d212121),
      selectedColor: Color(0x3dffffff),
      shape: StadiumBorder(
        side: BorderSide(
          color: Color(0x3dffffff),
          width: 0.0,
          style: BorderStyle.none,
        ),
      ),
    ),
    cardTheme: const CardTheme(
      color: ThemeColors.red,
      shadowColor: Color(0x3dffffff),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
      ),
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.transparent,
          width: 0.0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            8.0,
          ),
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: ThemeColors.blue.shade800,
    ),
    dividerTheme: const DividerThemeData(
      color: ThemeColors.offWhite,
      thickness: 1.0,
      space: 24.0,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ThemeColors.blue.shade800,
      // selectionColor: ThemeColors.teal.shade300,
      // selectionHandleColor: ThemeColors.teal,
    ),
  );
}
