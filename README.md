# Rapport d'Analyse Décisionnelle : Optimisation des Stocks
**Projet :** Mint Classics Co. — Plan de réorganisation des capacités de stockage
**Outils utilisés :** MySQL Workbench, Langage SQL

---

## 1. Description du Problème Métier
La compagnie Mint Classics Co. cherche à optimiser ses coûts opérationnels en **fermant l'un de ses quatre entrepôts de stockage**. L'objectif de cette étude est de proposer une stratégie de fermeture et de redistribution des inventaires sans dégrader la qualité ni la rapidité du service client.

---

## 2. Démarche Méthodologique
Pour identifier le meilleur candidat à la fermeture, l'analyse s'est articulée autour de trois axes clés en SQL :
1. **Évaluation volumétrique :** Quantification du stock physique réel disponible par site.
2. **Analyse de la performance commerciale :** Mesure des volumes de ventes (quantités commandées) attribués à chaque entrepôt.
3. **Calcul du taux de rotation (Taux d'écoulement) :** Croisement du stock et des ventes pour identifier le niveau d'efficience de chaque espace.

> 💡 **Note Technique (Portfolio) :** Lors de la phase d'analyse, une attention particulière a été portée aux pièges des jointures SQL (`JOIN`). L'utilisation d'une jointure directe simple provoquait un phénomène de produit cartésien partiel, dupliquant artificiellement les stocks de l'entrepôt B (East) à **211 450** ou **219 183** unités selon l'agrégation. Pour garantir l'exactitude des calculs, une approche par sous-requêtes indépendantes (tables dérivées) a été implémentée afin d'isoler le stock physique réel avant l'analyse des ventes. L'intégration de ces deux chiffres dans le script final démontre l'impact des biais de jointure sur la data integrity.

---

## 3. Synthèse des Résultats et Indicateurs Clés

L'exécution des requêtes optimisées a permis d'extraire les indicateurs décisionnels réels suivants :

* **Entrepôt A (North) :** 131 688 pièces en stock | 24 650 pièces vendues | **Taux d'écoulement : 18,72 %**
* **Entrepôt B (East) :** 219 183 pièces en stock | 35 582 pièces vendues | **Taux d'écoulement : 16,23 %** *(Plus faible performance / Surstockage)*
* **Entrepôt C (West) :** 124 880 pièces en stock | 22 933 pièces vendues | **Taux d'écoulement : 18,36 %**
* **Entrepôt D (South) :** 79 380 pièces en stock | 22 351 pièces vendues | **Taux d'écoulement : 28,16 %** *(Plus forte performance)*

---

## 4. Recommandations Stratégiques (Conclusions)

### A. Candidat idéal à la fermeture : L'entrepôt C (West)
L'entrepôt **C (West)** est désigné comme la structure à fermer en priorité pour les raisons suivantes :
* **Contrainte physique :** D'après les spécifications de l'entreprise, il s'agit du plus petit établissement en capacité.
* **Performance intermédiaire :** Bien qu'il affiche un taux d'écoulement correct (18,36 %), son volume global de ventes reste équivalent à celui de l'entrepôt D, tout en mobilisant un espace de stockage bien plus important (124 880 pièces contre 79 380).

### B. Plan de redistribution et optimisation
Pour absorber les 124 880 pièces de l'entrepôt C sans louer de nouvel espace, deux actions conjointes doivent être menées :
1. **Réduction du surstockage de l'entrepôt B (East) :** L'entrepôt B possède le taux d'écoulement le plus faible de la compagnie (16,23 %) et accumule plus de 219 000 pièces. Une politique de réduction stricte de 5 % à 10 % de ses références dormantes ou obsolètes libérera immédiatement la place nécessaire pour accueillir une partie des produits transférés.
2. **Exploitation de la performance de l'entrepôt D (South) :** L'entrepôt D est le plus efficace (28,16 % de rotation). Sa grande capacité théorique permettra de recevoir le reliquat des produits à forte rotation de l'entrepôt C, rapprochant ainsi les produits des standards d'expédition rapides.

---

## 5. Fichiers du Projet
* `README.md` : Le présent rapport d'analyse.
* `mintclassics_stock_analysis.sql` : Script SQL complet contenant les requêtes d'exploration, le calcul des pourcentages et les notes techniques.
