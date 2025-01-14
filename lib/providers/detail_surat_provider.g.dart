// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_surat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detailSuratHash() => r'b4b17b6a0886d70c57ab1b0d02d2bef937ec5b79';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DetailSurat extends BuildlessAsyncNotifier<DetailSuratModel> {
  late final int nomor;

  FutureOr<DetailSuratModel> build(
    int nomor,
  );
}

/// See also [DetailSurat].
@ProviderFor(DetailSurat)
const detailSuratProvider = DetailSuratFamily();

/// See also [DetailSurat].
class DetailSuratFamily extends Family<AsyncValue<DetailSuratModel>> {
  /// See also [DetailSurat].
  const DetailSuratFamily();

  /// See also [DetailSurat].
  DetailSuratProvider call(
    int nomor,
  ) {
    return DetailSuratProvider(
      nomor,
    );
  }

  @override
  DetailSuratProvider getProviderOverride(
    covariant DetailSuratProvider provider,
  ) {
    return call(
      provider.nomor,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'detailSuratProvider';
}

/// See also [DetailSurat].
class DetailSuratProvider
    extends AsyncNotifierProviderImpl<DetailSurat, DetailSuratModel> {
  /// See also [DetailSurat].
  DetailSuratProvider(
    int nomor,
  ) : this._internal(
          () => DetailSurat()..nomor = nomor,
          from: detailSuratProvider,
          name: r'detailSuratProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detailSuratHash,
          dependencies: DetailSuratFamily._dependencies,
          allTransitiveDependencies:
              DetailSuratFamily._allTransitiveDependencies,
          nomor: nomor,
        );

  DetailSuratProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nomor,
  }) : super.internal();

  final int nomor;

  @override
  FutureOr<DetailSuratModel> runNotifierBuild(
    covariant DetailSurat notifier,
  ) {
    return notifier.build(
      nomor,
    );
  }

  @override
  Override overrideWith(DetailSurat Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailSuratProvider._internal(
        () => create()..nomor = nomor,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nomor: nomor,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<DetailSurat, DetailSuratModel> createElement() {
    return _DetailSuratProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailSuratProvider && other.nomor == nomor;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nomor.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DetailSuratRef on AsyncNotifierProviderRef<DetailSuratModel> {
  /// The parameter `nomor` of this provider.
  int get nomor;
}

class _DetailSuratProviderElement
    extends AsyncNotifierProviderElement<DetailSurat, DetailSuratModel>
    with DetailSuratRef {
  _DetailSuratProviderElement(super.provider);

  @override
  int get nomor => (origin as DetailSuratProvider).nomor;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
