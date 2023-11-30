class Occurrence {
  String userId;
  String tipo;
  String localizacao;
  String descricao;
  String dataHora;

  Occurrence({
    required this.userId,
    required this.tipo,
    required this.localizacao,
    required this.descricao,
    required this.dataHora,
  });

  Occurrence.fromMap(Map<String, dynamic> map)
      : userId = map["userId"],
        tipo = map["tipo"],
        localizacao = map["localizacao"],
        descricao = map["descricao"],
        dataHora = map["dataHora"];

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "tipo": tipo,
      "localizacao": localizacao,
      "descricao": descricao,
      "dataHora": dataHora,
    };
  }
}
