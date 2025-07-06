# CountryApp - Quiz des Capitales avec Provider

CountryApp est une application Flutter simple et éducative qui propose un **quiz sur les capitales du monde** en utilisant les données en temps réel de l'API **REST Countries**. L’état global de l’application est géré efficacement grâce au package **`provider`**, qui permet une séparation claire entre l’interface et la logique métier. Le But est de mettre en pratique Provider.

---

## Fonctionnalités

- Chargement dynamique des pays depuis l’API [REST Countries](https://restcountries.com/)
- Quiz aléatoire de 10 questions avec capitales
- Gestion centralisée de l’état (score, index, loading, etc.) avec `Provider`
- Possibilité de rejouer le quiz facilement
- Indicateur de chargement pendant la récupération des données

---

## Structure du Projet

lib/
├── main.dart
├── quiz_screen.dart
├── quiz_provider.dart <-- Provider ici
└── country.dart

---

## Comment fonctionne Provider ici ?

L’application utilise un **ChangeNotifierProvider** pour injecter une instance de `QuizProvider` dans l’arborescence Flutter. Ce provider centralise :

| Élément                  | Rôle                                                                 |
|--------------------------|----------------------------------------------------------------------|
| `List<Country> countries`| Liste des pays avec nom + capitale                                  |
| `int score`              | Score de l’utilisateur                                               |
| `int currentIndex`       | Index de la question actuelle                                       |
| `bool isLoading`         | Indicateur de chargement pendant l’appel API                        |
| `void checkAnswer()`     | Vérifie si la réponse est correcte, puis passe à la suivante         |
| `void resetQuiz()`       | Réinitialise tout pour rejouer                                      |

Tout cela est exposé via des **getters**, et la classe appelle `notifyListeners()` pour **mettre à jour dynamiquement l’interface**.

---

## main.dart

```dart
ChangeNotifierProvider(
  create: (_) => QuizProvider(),
  child: const MyApp(),
)
Cela rend QuizProvider accessible dans tout le widget tree.

quiz_screen.dart
Ce fichier consomme le provider :

final quizProvider = Provider.of<QuizProvider>(context);

if (quizProvider.isLoading) {
  return CircularProgressIndicator();
}
Chaque bouton d’option appelle quizProvider.checkAnswer(...), ce qui met à jour l’état et la vue instantanément.

Appel API (dans quiz_provider.dart)
final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

_countries = data
  .where((c) => ...)
  .map((c) => Country(name: ..., capital: ...))
  .toList();
Seuls les pays avec une capitale valide sont ajoutés.

Installation & Lancement
Clone le repo :

git clone https://github.com/YacDms/CountryAppWithProvider.git
cd CountryAppWithProvider
flutter pub get
flutter run
Assure-toi d’avoir un émulateur ou appareil connecté

Dépendances principales
-------------------------------------------------
Package	        |  Rôle
-------------------------------------------------
provider        |	 Gestion d’état global
-------------------------------------------------
http	          |  Requêtes HTTP pour l’API REST
-------------------------------------------------
cupertino_icons	|  Icônes iOS optionnelles
-------------------------------------------------

Auteur
Réalisé par Yacine Dehmous
AEC Programmation Orientée Objet et Technologies Web – Cégep ROSEMONT
Passionnée de tech, d’IA et d’apprentissage
