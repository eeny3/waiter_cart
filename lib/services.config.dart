// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:waiter_cart/database/app_database.dart' as _i256;
import 'package:waiter_cart/database/repositories/menu_item_repository.dart'
    as _i421;
import 'package:waiter_cart/database/repositories/order_repository.dart'
    as _i813;
import 'package:waiter_cart/database/repositories/table_repository.dart'
    as _i202;
import 'package:waiter_cart/stores/order_store/order_store.dart' as _i950;
import 'package:waiter_cart/stores/table_store/table_store.dart' as _i322;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i256.AppDatabase>(() => _i256.AppDatabase());
    gh.factory<_i421.MenuItemRepository>(
        () => _i421.MenuItemRepository(gh<_i256.AppDatabase>()));
    gh.factory<_i813.OrderRepository>(
        () => _i813.OrderRepository(gh<_i256.AppDatabase>()));
    gh.factory<_i202.TableRepository>(
        () => _i202.TableRepository(gh<_i256.AppDatabase>()));
    gh.factory<_i950.OrderStore>(() => _i950.OrderStore(gh<int>()));
    gh.factory<_i322.TableStore>(
        () => _i322.TableStore(gh<_i202.TableRepository>()));
    return this;
  }
}
