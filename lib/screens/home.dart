import 'package:bmi_calculator/admob/google_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numberpicker/numberpicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMale = true;
  int? height = 150;
  int? weight = 50;
  int? age = 20;
  double bmi = 0.0;
  String bmiSonuc = '';

  @override
  void initState() {
    super.initState();
    GoogleAds.loadBannerAd(
      onAdLoaded: () {
        setState(() {});
      },
    );
    GoogleAds.loadInterstitialAd(showAfterLoad: true);
  }

  Map<String, double> dataMap = {
    "": 90,
    "Çok Zayıf": 15,
    "Zayıf": 20,
    "İdeal": 20,
    "Kilolu": 20,
    "Obez": 15,
  };

  @override
  Widget build(BuildContext context) {
    var colorList = [
      Colors.transparent,
      Colors.blueAccent,
      Colors.yellow,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white60,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (GoogleAds.bannerAd != null)
                    Container(
                      width: GoogleAds.bannerAd!.size.width.toDouble(),
                      height: GoogleAds.bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: GoogleAds.bannerAd!),
                    ),

                  //! Yaş Boy Kilo Container
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Height (cm)",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  NumberPicker(
                                    value: height ?? 0,
                                    minValue: 10,
                                    maxValue: 300,
                                    itemCount: 3,
                                    selectedTextStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    onChanged: (value) =>
                                        setState(() => height = value),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("Weight (kg)",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  NumberPicker(
                                    value: weight ?? 0,
                                    minValue: 0,
                                    maxValue: 300,
                                    selectedTextStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    onChanged: (value) =>
                                        setState(() => weight = value),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Age",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  NumberPicker(
                                    value: age ?? 0,
                                    minValue: 2,
                                    maxValue: 150,
                                    selectedTextStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    onChanged: (value) =>
                                        setState(() => age = value),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        
                        // Cinsiyet checkbox
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //! info icon
                              IconButton(
                                onPressed: () {
                                  GoogleAds.loadInterstitialAd(
                                      showAfterLoad: true);
                                },
                                icon: const Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              //! Cinsiyet seçimi
                              Checkbox(
                                value: isMale,
                                onChanged: (value) {
                                  setState(() {
                                    isMale = value!;
                                  });
                                },
                              ),
                              const Text(
                                "Male",
                                style: TextStyle(color: Colors.white),
                              ),
                              Checkbox(
                                value: !isMale,
                                onChanged: (value) {
                                  setState(() {
                                    isMale = !value!;
                                  });
                                },
                              ),
                              const Text(
                                "Female",
                                style: TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              //! refresh icon
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    height = 150;
                                    weight = 50;
                                    age = 20;
                                    bmi = 0.0;
                                    bmiSonuc = '';
                                    isMale = true;
                                  });
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //! Calculate Button
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          calculateBMI();
                        },
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //! BMI result Container Height weight age ve cinsiyet bilgileri ve BMI sonucu ekranda gösterilir
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 10.0,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Height = $height cm",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Weight = $weight kg",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Text(
                                    "Age = $age years",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Text(
                                      isMale == true
                                          ? "Gender = Male"
                                          : "Gender = Female",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // bmi sonucu
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "BMI = ${bmi.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              bmiSonuc,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                  //! admob reklamı,
                  // pie chart ile görselleştirme
                  const SizedBox(
                    height: 30,
                  ),
                  /*  PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 2.14,
                    colorList: colorList,
                    initialAngleInDegree: 0,

                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    centerText: "BMI",

                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.left,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      showChartValues: false,
                      decimalPlaces: 1,
                      chartValueStyle: TextStyle(
                        color: Colors.blueGrey[900],
                        fontSize: 16,
                      ),
                    ),

                    // gradientList: ---To add gradient colors---
                    // emptyColorGradient: ---Empty Color gradient---
                  ),
              */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    if (height! > 0 && weight! > 0 && age! > 0) {
      final double heightM = height! / 100;
      setState(() {
        bmi = weight! / (heightM * heightM);
        bmiSonuc = _bmiKategori(bmi, age!, isMale);
      });
    }
  }

  String _bmiKategori(double bmi, int yas, bool cinsiyet) {
    if (yas < 18) {
      // Çocuklar ve gençler için kategorilendirme (cinsiyete göre ayrım)
      if (cinsiyet == true) {
        if (bmi < 14.0) return 'Çok Zayıf';
        if (bmi < 17.5) return 'Zayıf';
        if (bmi < 23.0) return 'İdeal';
        if (bmi < 27.0) return 'Kilolu';
        return 'Obez';
      } else if (cinsiyet == false) {
        if (bmi < 13.5) return 'Çok Zayıf';
        if (bmi < 17.0) return 'Zayıf';
        if (bmi < 22.5) return 'İdeal';
        if (bmi < 26.5) return 'Kilolu';
        return 'Obez';
      }
    } else {
      // Yetişkinler için kategorilendirme (cinsiyete göre ayrım)
      if (cinsiyet == true) {
        if (bmi < 16.0) return 'Çok Zayıf';
        if (bmi < 18.5) return 'Zayıf';
        if (bmi < 25.0) return 'İdeal';
        if (bmi < 30.0) return 'Kilolu';
        return 'Obez';
      } else if (cinsiyet == false) {
        if (bmi < 16.0) return 'Çok Zayıf';
        if (bmi < 18.5) return 'Zayıf';
        if (bmi < 24.0) return 'İdeal';
        if (bmi < 29.0) return 'Kilolu';
        return 'Obez';
      }
    }

    // Eğer cinsiyet belirtilmemişse (bu durumda yanlış veri girildiği varsayımı yapılır)
    return 'Geçersiz veri';
  }
}
