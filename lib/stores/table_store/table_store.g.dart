// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TableStore on _TableStore, Store {
  late final _$tablesAtom = Atom(name: '_TableStore.tables', context: context);

  @override
  ObservableList<TableModel> get tables {
    _$tablesAtom.reportRead();
    return super.tables;
  }

  @override
  set tables(ObservableList<TableModel> value) {
    _$tablesAtom.reportWrite(value, super.tables, () {
      super.tables = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_TableStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadTablesAsyncAction =
      AsyncAction('_TableStore.loadTables', context: context);

  @override
  Future<void> loadTables() {
    return _$loadTablesAsyncAction.run(() => super.loadTables());
  }

  late final _$updateTableAvailabilityAsyncAction =
      AsyncAction('_TableStore.updateTableAvailability', context: context);

  @override
  Future<void> updateTableAvailability(int id, bool isAvailable) {
    return _$updateTableAvailabilityAsyncAction
        .run(() => super.updateTableAvailability(id, isAvailable));
  }

  @override
  String toString() {
    return '''
tables: ${tables},
isLoading: ${isLoading}
    ''';
  }
}
