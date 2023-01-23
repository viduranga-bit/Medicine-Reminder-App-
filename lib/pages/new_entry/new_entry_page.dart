import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:medicine_reminder_app/models/medicine_type.dart';
import 'package:sizer/sizer.dart';

class newEntryPage extends StatefulWidget {
  const newEntryPage({Key? key}) : super(key: key);

  @override
  State<newEntryPage> createState() => _newEntryPageState();
}

class _newEntryPageState extends State<newEntryPage> {
  late TextEditingController nameController;
  late TextEditingController dossageController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    dossageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add New"),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelTitle(
              title: "Medicine Name",
              isRequired: true,
            ),
            TextFormField(
              maxLength: 12,
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(border: UnderlineInputBorder()),
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: kOtherColor),
            ),
            PanelTitle(
              title: "Dosage in (mg)",
              isRequired: false,
            ),
            TextFormField(
              maxLength: 12,
              controller: dossageController,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(border: UnderlineInputBorder()),
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: kOtherColor),
            ),
            const PanelTitle(title: 'Medicine Type', isRequired: false),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: StreamBuilder(
                builder: ((context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MedicineTpeColumn(
                          medicineType: MedicineType.Bottle,
                          name: "Bottle",
                          iconValue: "assets/icons/pill.svg",
                          isSelected: snapshot.data == MedicineType.Bottle
                              ? true
                              : false),
                      MedicineTpeColumn(
                          medicineType: MedicineType.Pill,
                          name: "Pill",
                          iconValue: "assets/icons/pill.svg",
                          isSelected: snapshot.data == MedicineType.Bottle
                              ? true
                              : false),
                      MedicineTpeColumn(
                          medicineType: MedicineType.Syringe,
                          name: "Syringe",
                          iconValue: "assets/icons/pill.svg",
                          isSelected: snapshot.data == MedicineType.Bottle
                              ? true
                              : false),
                      MedicineTpeColumn(
                          medicineType: MedicineType.Tablet,
                          name: "Tablet",
                          iconValue: "assets/icons/pill.svg",
                          isSelected: snapshot.data == MedicineType.Bottle
                              ? true
                              : false)
                    ],
                  );
                }),
              ),
            ),
            const PanelTitle(title: "Interval selection", isRequired: true),
            IntervalSelection(),
          ],
        ),
      ),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  IntervalSelection({Key? key}) : super(key: key);

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Remind me every",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          DropdownButton(
            iconEnabledColor: kOtherColor,
            dropdownColor: kScaffoldColor,
            itemHeight: 8.h,
            hint: _selected == 0
                ? Text(
                    "Selecte an Interval",
                    style: Theme.of(context).textTheme.caption,
                  )
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(() {
                _selected = newVal!;
              });
            },
          ),
          Text(
            _selected == 1 ? "Hour" : "Hours",
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({Key? key, required this.title, required this.isRequired})
      : super(key: key);
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
          text: title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        TextSpan(
            text: isRequired ? " *" : " ",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: kPrimaryColor,
                ))
      ])),
    );
  }
}

class MedicineTpeColumn extends StatelessWidget {
  const MedicineTpeColumn(
      {Key? key,
      required this.medicineType,
      required this.name,
      required this.iconValue,
      required this.isSelected})
      : super(key: key);
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //select medicine type
      },
      child: Column(
        children: [
          Container(
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.h),
                color: isSelected ? kOtherColor : Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: SvgPicture.asset(
                  iconValue,
                  height: 7.h,
                  color: isSelected ? Colors.white : kOtherColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 20.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: isSelected ? kOtherColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: isSelected ? Colors.white : kOtherColor),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
