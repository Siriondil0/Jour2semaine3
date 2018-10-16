# Jour2semaine3

Projet fait au début en collaboration avec Romain Recher

Le fichier colorization.rb contient des ajouts de def à la classe strings permettant de colorer les chaines de caractères selon les besoins.
Le fichier gameboard.rb contient les classes Player, BoardCase et Board.
Le fichier tictactoe.rb contient la classe Game.
Le fichier perform.rb permet de lancer le jeu.

La classe Game contient les fonctions capables d'initialiser un jeu (avec un plateau, deux joueurs et le nom du premier joeur), et de le jouer
La classe Board contient notamment les fonctions capables d'initialiser le plateau (avec 9 cases) , et de le manipuler (afficher, vérifier des valeurs ...).
La classe BoardCase permet d'initialiser une case, avec une valeur initiale "=".
La classe Player permet de creer un joueur "name" avec un symbole et un compte de ses victoires.