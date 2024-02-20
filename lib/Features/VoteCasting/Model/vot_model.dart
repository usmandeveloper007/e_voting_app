class VotModel {
  String? votId;
  String? votTo;
  String? votFrom;
  String? votAt;
  String? electionType;

  VotModel(
      {this.votId, this.votTo, this.votFrom, this.votAt, this.electionType});

  VotModel.fromJson(Map<String, dynamic> json) {
    votId = json['votId'];
    votTo = json['votTo'];
    votFrom = json['votFrom'];
    votAt = json['votAt'];
    electionType = json['electionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['votId'] = this.votId;
    data['votTo'] = this.votTo;
    data['votFrom'] = this.votFrom;
    data['votAt'] = this.votAt;
    data['electionType'] = this.electionType;
    return data;
  }
}
