import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'job_model.g.dart';

@HiveType(typeId: 1)
class JobModel extends Equatable {
  @HiveField(0)
  final DateTime? createdAt;
  
  @HiveField(1)
  final String? name;
  
  @HiveField(2)
  final String? companyname;
  
  @HiveField(3)
  final String? address;
  
  @HiveField(4)
  final String? about;
  
  @HiveField(5)
  final String? image;
  
  @HiveField(6)
  final String? id;
  
  @HiveField(7)
  final bool? fav;

  const JobModel({
    this.createdAt,
    this.name,
    this.companyname,
    this.address,
    this.about,
    this.image,
    this.id,
    this.fav,
  });

  factory JobModel.fromMap(Map<String, dynamic> json) => JobModel(
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        name: json['name'] as String?,
        companyname: json['companyname'] as String?,
        address: json['address'] as String?,
        about: json['about'] as String?,
        image: json['image'] as String?,
        id: json['id'] as String?,
        fav: json['fav'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt?.toIso8601String(),
        'name': name,
        'companyname': companyname,
        'address': address,
        'about': about,
        'image': image,
        'id': id,
        'fav': fav,
      };

  JobModel copyWith({
    DateTime? createdAt,
    String? name,
    String? companyname,
    String? address,
    String? about,
    String? image,
    String? id,
    bool? fav,
  }) {
    return JobModel(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      companyname: companyname ?? this.companyname,
      address: address ?? this.address,
      about: about ?? this.about,
      image: image ?? this.image,
      id: id ?? this.id,
      fav: fav ?? this.fav,
    );
  }

  @override
  List<Object?> get props => [createdAt, name, companyname, address, about, image, id, fav];
}
