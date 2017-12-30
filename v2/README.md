# TestGesture - Version 2
Essai de reconnaissance de formes à partir de la distance à un modèle.

## Comment utiliser
Tracer une forme avec la souris. Appuyer sur la flèche de gauche pour transformer la forme (cf. Abstract). Appuer sur la flèche du bas pour reconnaitre la forme affichée. Appuyer sur la flèche du haut pour recommencer la phase d'enregistrement des modèles et SHIFT pour enregistrer un modèle.   
Remarque : Il faut procéder à la transformation manuelle (flèche de gauche jusqu'à ce que la forme n'évolue plus) avant d'entegistrer ou de reconnaitre une forme.

## Abstract
Un premier nuage de point est tracé par l'utilisateur.   
1. Seuls les points critiques sont conservés.
2. Les segments sont découpés en points espacés régulièrement.
3. Un nombre prédéfini de points est conservé.   
La distance entre les points de la forme obtenue et les points des modèles est sommée pour obtenir la distance de la forme à chaque modèle. La distance la plus faible correspond à la forme choisie.
