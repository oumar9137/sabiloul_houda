# Sabiloul Houda — logiciel scolaire

Application de bureau locale pour la Medersa Franco-Arabe Sabiloul Houda. Les données sont conservées dans un fichier SQLite local.

## Objectif

Construire par étapes une application Windows hors ligne, en français et compatible avec les textes arabes. Aucune connexion Internet ni serveur de base de données n'est nécessaire.

## Première version

Le prototype propose les écrans élèves, classes, frais dus par élève, paiements partiels, reçus PDF, dépenses, rapports exportables en CSV ou Excel, sauvegardes/restauration, journal des opérations, personnel, présence quotidienne, matières, notes, moyennes et bulletins PDF. Les notes sont ramenées à une échelle de 10 pour calculer une moyenne simple.

## Démarrage

1. Installer Python 3 sur Windows.
2. Ouvrir PowerShell dans ce dossier.
3. Installer les bibliothèques PDF et de mise en forme arabe : `python -m pip install -r requirements.txt`.
4. Lancer `python main.py`.

Pour créer un reçu, ouvrez l'onglet **Paiements**, sélectionnez le règlement dans la liste, puis cliquez sur **Créer le reçu PDF du paiement sélectionné**. Le fichier est proposé dans `data/recus` et s'ouvre ensuite pour impression.

Pour créer un rapport, ouvrez l'onglet **Rapports**, choisissez la liste des élèves, les frais impayés, les paiements ou les dépenses, puis cliquez sur **Afficher**. Vous pouvez ensuite exporter le tableau affiché en CSV ou Excel.

Dans **Sauvegarde & journal**, vous pouvez enregistrer une copie de la base SQLite, restaurer une sauvegarde validée et consulter les 500 dernières opérations journalisées. Avant une restauration, le logiciel crée une copie de sécurité de la base actuelle.

Dans **Personnel**, ajoutez les enseignants et leurs informations. Dans **Présences**, choisissez la date et la classe, puis enregistrez le statut de chaque élève. Une correction d'une présence déjà saisie demande confirmation et apparaît dans le journal. Les présences peuvent aussi être exportées depuis **Rapports**.

Dans **Matières & notes**, associez des matières aux classes, saisissez les notes par trimestre et année scolaire, puis générez un bulletin PDF pour l'élève sélectionné. Les corrections de notes sont confirmées et enregistrées dans le journal.

L'application utilise Tkinter et SQLite, inclus dans les installations standard de Python. ReportLab génère les reçus PDF. Au premier lancement depuis le code, le fichier `data/sabiloul_houda.sqlite3` est créé dans le dossier du projet. Dans la version `.exe`, les données sont conservées dans `%LOCALAPPDATA%\SabiloulHouda\data`, séparément du programme.

## Principes de données

- Une inscription relie l'élève à une classe et une année scolaire.
- Les paiements sont conservés comme opérations distinctes des frais attendus, afin de pouvoir gérer les paiements partiels.
- Les opérations financières ne sont pas effacées par une action de suppression ordinaire.
- L'année configurée au démarrage est 2026-2027.
- Pour utiliser les mêmes données sur un autre PC, fermez le logiciel et copiez le dossier `data` vers le dossier de l'application sur le nouvel ordinateur.
- Faites régulièrement une copie de sauvegarde de ce fichier sur une clé USB.

## Création de l'application Windows

Sur un PC Windows connecté à Internet, double-cliquez sur `build_windows.bat`. Le fichier `dist\Sabiloul Houda.exe` sera créé. Il inclut Python et les bibliothèques du logiciel ; Python n'aura donc pas besoin d'être installé sur le PC cible. Les données restent dans le profil Windows, dans `%LOCALAPPDATA%\SabiloulHouda\data`. Pour déplacer les données d'un PC à l'autre, créez une sauvegarde dans le logiciel puis restaurez-la sur le nouvel ordinateur.

## Évolution prévue

1. Élèves, responsables, classes et inscriptions.
2. Frais par élève, versements partiels et soldes restants.
3. Reçus PDF et dépenses.
4. Sauvegardes/restauration et journal des opérations.
5. Vérification finale sur Windows 10 et création du fichier `.exe` avec `build_windows.bat`.

Les fonctions doivent être vérifiées sur le PC cible avec des données fictives avant toute utilisation réelle.
