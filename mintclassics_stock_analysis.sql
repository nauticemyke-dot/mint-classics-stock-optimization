-- ==============================================================================
-- PROJET PORTFOLIO : ANALYSE DES STOCKS MINT CLASSICS
-- Objectif : Identifier quel entrepôt pourrait être fermé.
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- REQUÊTE 1 : Liste et description des entrepôts disponibles
-- ------------------------------------------------------------------------------
-- Cette requête nous permet de connaître le nom et la capacité relative de chaque site de stockage de l'entreprise.
Select * from warehouses;

-- D'après les résultats, Mint Classics possède quatre (4) entrepôts différents qui sont North, East,West et South.
-- Leurs codes sont respectivements A,B,C et D. On remarque que l'entrepôt South avec le code D est le plus grand et l'entrepôt West avec le code C est le plus petit.


-- ------------------------------------------------------------------------------
-- REQUÊTE 2 : Nombre de produits uniques par entrepôt
-- ------------------------------------------------------------------------------
-- Cette requête compte la variété (le nombre de références uniques) de produits stockés dans chaque bâtiment.
Select warehouseCode, 
count(*) as nombre_de_produits
from products
group by warehouseCode;

-- Les résultats montrent une répartition intéressante :
-- * L'entrepôt A contient 25 produits uniques.
-- * L'entrepôt B contient 38 produits uniques.
-- * L'entrepôt C contient 24 produits uniques.
-- * L'entrepôt D contient 23 produits uniques.
-- On peut remarquer que c'est l'entrepôt D qui gère le moins de références de produits avec 23 produits uniques.


-- ------------------------------------------------------------------------------
-- REQUÊTE 3 : Volume total de pièces physiques en stock par entrepôt
-- ------------------------------------------------------------------------------
-- Cette requête fait la somme de toutes les quantités en stock pour évaluer le volume total pièces physiques par entrepôt.
Select warehouseCode, 
sum(quantityInStock) as total_pièces_en_stock
from products
group by warehouseCode;

-- En observant le volume global de marchandises :
-- * L'entrepôt A stocke un total de 131688 pièces.
-- * L'entrepôt B stocke un total de 219183 pièces.
-- * L'entrepôt C stocke un total de 124880 pièces.
-- * L'entrepôt D stocke un total de 79380 pièces.

-- L'entrepôt D possède le plus faible volume de stock physique avec seulement 79380 pièces au total. 
-- C'est le premier candidat potentiel à la fermeture.

-- Conclusion globale de la première analyse : Contre toute attente, c'est l'entrepôt D (South) qui possède le plus faible volume de stock physique, alors qu'il a la plus grande capacité théorique.


-- ------------------------------------------------------------------------------
-- REQUÊTE 4 : Taux d'écoulement (Pourcentage des ventes par rapport au stock)
-- ------------------------------------------------------------------------------
-- Cette requête calcule la performance de chaque entrepôt en montrant quel  pourcentage de son stock actuel a été vendu.
SELECT 
    p.warehouseCode,
    SUM(distinct p.quantityInStock) AS volume_en_stock_reel,
    SUM(od.quantityOrdered) AS volume_vendu,
    ROUND((SUM(od.quantityOrdered) / SUM(distinct p.quantityInStock)) * 100, 2) AS pourcentage_vente_par_stock
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.warehouseCode;

-- L'analyse de l'efficacité des stocks par entrepôt révèle :
-- * L'entrepôt A (North) a un taux d'écoulement de 18.72 %.
-- * L'entrepôt B (East) a un taux d'écoulement de 16.23 %.
-- * L'entrepôt C (West) a un taux d'écoulement de 18.36 %.
-- * L'entrepôt D (South) a un taux d'écoulement de 28.16 %.
--
-- INTERPRÉTATION FINALE ET RECOMMANDATIONS :
-- 1. L'entrepôt D (South) est de loin le plus performant avec un taux de rotation de 28.16%.
--    Il optimise parfaitement son espace malgré le fait qu'il possède le plus petit volume de stock (79 380).
-- 2. L'entrepôt B (East) présente la performance la plus faible (16.83%) et souffre d'un surstockage 
--    massif (219 183 pièces). Une réduction de 5 à 10% de son inventaire permettrait de libérer de l'espace.
-- 3. PROPOSITION DE FERMETURE : L'entrepôt C (West) est le candidat idéal pour la fermeture.
--    Sa description indique que c'est le plus petit établissement. Son stock (124 880 pièces) peut être 
--    facilement absorbé en combinant la réduction du surstock de l'entrepôt B et le transfert du reste 
--    des produits vers les espaces disponibles de l'entrepôt D (le plus grand physiquement) et de l'entrepôt A.
