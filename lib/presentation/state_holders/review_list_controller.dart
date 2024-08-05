import 'package:commerce/data/models/network_response.dart';
import 'package:commerce/data/models/review_list_model.dart';
import 'package:commerce/data/services/network_caller.dart';
import 'package:commerce/data/utils/url_links.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  bool _getReviewInProgress = false;
  ReviewListModel _reviewData = ReviewListModel();
  String _message = "";

  bool get getReviewListInProgress => _getReviewInProgress;
  ReviewListModel get reviewData => _reviewData;
  String get message => _message;

  Future<bool> getReview(int id) async {

  //     db.collection("products").get().then(
  //     (querySnapshot) {
  //       List<NewProduct> temp = [];
  //       for (var docSnapshot in querySnapshot.docs) {
  //         temp.add(NewProduct.fromJson(docSnapshot.data()));
  //         log('${docSnapshot.id} => ${docSnapshot.data()}');
  //       }
  //       products = temp;
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  // }
    _getReviewInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.listReviewById(id));
    _getReviewInProgress = false;
    if (response.isSuccess && response.statusCode == 200) {
      _reviewData = ReviewListModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = "review show failed";
      update();
      return false;
    }
  }
}
