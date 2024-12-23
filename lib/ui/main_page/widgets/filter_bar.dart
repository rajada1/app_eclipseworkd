import 'package:app_eclipseworkd/ui/main_page/view_model/main_view_models.dart';
import 'package:app_eclipseworkd/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FilterBarWidget extends StatelessWidget {
  const FilterBarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Modular.get<MainViewModel>();
    return Card(
      child: ListenableBuilder(
          listenable: viewModel.setDateFilter,
          builder: (_, __) {
            return Row(
              spacing: 10,
              children: [
                SizedBox(width: 10),
                Text('Filtros:'),
                TextButton.icon(
                    label: Text(viewModel.dateFilter.formatDateRangeFilterBar),
                    onPressed: () async {
                      final result = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (result is DateTimeRange) {
                        await viewModel.setDateFilter.execute(result);
                        viewModel.load.execute(false);
                      }
                    },
                    icon: Icon(Icons.calendar_month_outlined)),
                Spacer(),
                TextButton.icon(
                    onPressed: () {
                      viewModel.load.execute(true);
                    },
                    icon: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    label: Text('Simular erro'))
              ],
            );
          }),
    );
  }
}
