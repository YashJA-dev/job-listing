// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobModelAdapter extends TypeAdapter<JobModel> {
  @override
  final int typeId = 1;

  @override
  JobModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobModel(
      createdAt: fields[0] as DateTime?,
      name: fields[1] as String?,
      companyname: fields[2] as String?,
      address: fields[3] as String?,
      about: fields[4] as String?,
      image: fields[5] as String?,
      id: fields[6] as String?,
      fav: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, JobModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.companyname)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.about)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.fav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
