import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting_app/Features/VoteCasting/Model/vot_model.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Features/Authentication/Model/city_party_model.dart';
import '../Features/Authentication/Model/user_model.dart';
import '../Features/VoteCasting/Model/election_model.dart';
import 'firebase_exceptions.dart';

class FireStoreServices {
  static var usersCollection=FirebaseFirestore.instance.collection('Users');
  static var votesCollection=FirebaseFirestore.instance.collection('Votes');
  static var electionCollection=FirebaseFirestore.instance.collection('Election');
  static var cityPartyNamesCollection=FirebaseFirestore.instance.collection('CityPartyNames');
  static final auth = FirebaseAuth.instance;

  static Future uploadUserData(UserModel user) async {
    try {
      await usersCollection.doc(user.userId).set(user.toJson());
      return true;
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }


  static Future<UserModel?> getUser() async {
    try {
      final userId = auth.currentUser?.uid;
      DocumentSnapshot documentSnapshot = await usersCollection.doc(userId).get();
      if(documentSnapshot.data()!=null){
        UserModel user = UserModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        return user;
      }else{
        return null;
      }
    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }


  static Stream<List<UserModel>> getCandidatesStream({required String cityName, required String electionType}) {
    final Query userQuery = usersCollection
        .where('userType', isEqualTo: AppStrings.candidate)
        .where('isApproved', isEqualTo: true)
        .where('electionType', isEqualTo: electionType)
        .where('city', isEqualTo: cityName);

    return userQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson(data);
      }).toList();
    });
  }

  static Future postNewVot(VotModel vot) async {
    try {
      await votesCollection.doc(vot.votId).set(vot.toJson());
      return true;
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }

  static Stream<bool> checkIfUserHasVoted(String electionType) {
    final userId = auth.currentUser?.uid;
    final Query voteQuery = votesCollection
        .where('votFrom', isEqualTo: userId)
        .where('electionType', isEqualTo: electionType);
    return voteQuery.snapshots().map((querySnapshot) {
      return querySnapshot.docs.isEmpty;
    });
  }

  static Stream<int> getVoteResultsStream({required String canId, required String electionType}) {
    final Query userQuery = votesCollection
        .where('electionType', isEqualTo: electionType)
        .where('votTo', isEqualTo: canId);

    return userQuery.snapshots().map((snapshot) {
      return snapshot.docs.length;
    });
  }

  static Stream<List<String>> fetchAllCityNames() {
    return usersCollection.snapshots().map(
          (QuerySnapshot querySnapshot) {
        final cityNames = <String>{};
        querySnapshot.docs.forEach((doc) {
          final cityName = doc['city'] as String;
          cityNames.add(cityName);
        });
        return cityNames.toList();
      },
    );
  }

  static Stream<ElectionModel> getElectionStream(String type) {
    final Query userQuery = electionCollection
        .where('type', isEqualTo: type);

    return userQuery.snapshots().map((snapshot) {
      return snapshot.docs.isNotEmpty
          ? ElectionModel.fromJson(snapshot.docs.first.data() as Map<String, dynamic>)
          : ElectionModel();
    });
  }

  static Stream<List<UserModel>> getAllUserStream() {
    return usersCollection.snapshots().map((querySnapshot) {
      List<UserModel> users = [];
      querySnapshot.docs.forEach((doc) {
        UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        users.add(user);
      });
      return users;
    });
  }


  static Future updateUserGallery({required List urlList}) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await usersCollection.doc(userId).update({
        'gallery' : urlList
      });
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    } catch(e){
      throw e.toString();
    }
  }

  static Future<bool> updateUserProfile(Map<String, dynamic> data) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await usersCollection.doc(userId).update(data);
      return true;
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    } catch(e){
      throw e.toString();
    }
  }

  static isCNICExist(int cNIC) async {
    QuerySnapshot queryDocumentSnapshot=await usersCollection.where('cNIC',isEqualTo: cNIC).get();
    if(queryDocumentSnapshot.size>0){
      return true;
    }
    return false;
  }

  static isCandidateExist(String cityName, String partyType) async {
    QuerySnapshot queryDocumentSnapshot=await usersCollection.where(
        'userType', isEqualTo: AppStrings.candidate)
    .where('city', isEqualTo: cityName)
    .where('partType',isEqualTo: partyType)
        .get();
    if(queryDocumentSnapshot.size>0){
      return true;
    }
    return false;
  }


  static Future deleteUserProfile({required String userId}) async {
    try {
      await usersCollection.doc(userId).delete();
      return true;
    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }

  static Future<CityPartyModel?> getCityPartyName() async {
    try {
      DocumentSnapshot documentSnapshot = await cityPartyNamesCollection.doc("cityPartyNames").get();
      if(documentSnapshot.data()!=null){
        CityPartyModel names = CityPartyModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        return names;
      }else{
        return null;
      }

    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }


}