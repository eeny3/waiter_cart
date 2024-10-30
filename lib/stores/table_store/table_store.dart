import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:waiter_cart/database/repositories/table_repository.dart';
import 'package:waiter_cart/models/table/table_model.dart';

part 'table_store.g.dart';

@injectable
// ignore: library_private_types_in_public_api
class TableStore = _TableStore with _$TableStore;

abstract class _TableStore with Store {
  final TableRepository _tableRepository;

  _TableStore(this._tableRepository);

  Future<void> init() async {
    await loadTables();
  }

  @observable
  ObservableList<TableModel> tables = ObservableList<TableModel>();

  @observable
  bool isLoading = false;

  @action
  Future<void> loadTables() async {
    isLoading = true;
    final tableList = await _tableRepository.getAllTables();
    tables = ObservableList.of(tableList);
    isLoading = false;
  }

  @action
  Future<void> updateTableAvailability(int id, bool isAvailable) async {
    isLoading = true;
    await _tableRepository.updateTableAvailability(id, isAvailable);
    isLoading = false;
    loadTables();
  }
}