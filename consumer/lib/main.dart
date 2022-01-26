import 'dart:convert';
import 'dart:math';

import 'state.dart';
import 'http.dart';

final client = ClientHttp();

const String ENDPOINT = "products";

List<Map<String, dynamic>> generateList() {
  return List<Map<String, dynamic>>.generate(
    3000,
    (int index) {
      return {
        "title": "Product #$index",
        "error": Random().nextBool(),
      };
    },
  );
}

Stream<State> populateDb() async* {
  for (final product in generateList()) {
    if (product['error']) {
      yield ErrorState("product: $product can not be saved!");
    } else {
      print("product saved: ${product}");
      yield SuccessState<Future<String>>(client.post(ENDPOINT, product));
    }
  }
}

void main() async {
  await for (State state in populateDb()) {
    if (state is SuccessState<Future<String>>) {
      final parsedData = jsonDecode(await state.data);
      final response = await client.get("$ENDPOINT/${parsedData['id']}");
      print("product data: ${response}");
    }

    if (state is ErrorState) {
      print(state.message);
    }
  }
}
