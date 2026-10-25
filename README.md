# Sabiloul Houda — logiciel scolaire

Application de bureau locale pour la Medersa Franco-Arabe Sabiloul Houda. Les données sont conservées dans un fichier SQLite local.

## Objectif

Construire par étapes une application Windows hors ligne, en français et compatible avec les textes arabes. Aucune connexion Internet ni serveur de base de données n'est nécessaire.

## Première version

Le prototype propose les écrans élèves, classes, frais dus par élève, paiements partiels, reçus PDF, dépenses, rapports exportables en CSV ou Excel, sauvegardes/restauration, journal des opérations, personnel, présence quotidienne, matières, notes, moyennes et bulletins PDF. Les notes sont ramenées à une échelle de 10 pour calculer une moyenne simple. Les fiches élèves, classes, frais, paiements, dépenses, personnel, présences, matières et notes disposent de commandes de modification et de suppression/archivage après sélection. Les suppressions demandent confirmation et sont inscrites dans le journal.

Les classes, élèves, matières et membres du personnel sont archivés plutôt qu'effacés définitivement lorsque leurs dossiers sont liés à d'autres données. Le bouton **Archiver / réactiver** permet de les retirer des choix courants puis de les restaurer. Le journal des opérations reste conservé afin de garder l'historique des changements.

Le matricule des élèves est attribué automatiquement à l'inscription : `S001`, `S002`, `S003`, etc. Les élèves déjà présents dans une ancienne base seront renumérotés au premier lancement de cette version, selon leur ordre d'inscription. Le matricule reste ensuite fixe, même après une suppression, pour éviter de réutiliser un numéro. Dans l'onglet **Élèves**, le filtre **Afficher les élèves de la classe** permet de n'afficher que les élèves d'une classe ou de revenir à **Toutes les classes**.

## Démarrage

1. Installer Python 3 sur Windows.
2. Ouvrir PowerShell dans ce dossier.
3. Installer les bibliothèques PDF et de mise en forme arabe : `python -m pip install -r requirements.txt`.
4. Lancer `python src/main.py` depuis la racine du projet.

Pour créer un reçu, ouvrez l'onglet **Paiements**, sélectionnez le règlement dans la liste, puis cliquez sur **Créer le reçu PDF du paiement sélectionné**. Le fichier est proposé dans `data/recus` et s'ouvre ensuite pour impression.

Pour créer un rapport, ouvrez l'onglet **Rapports**, choisissez la liste des élèves, les frais impayés, les paiements ou les dépenses, puis cliquez sur **Afficher**. Vous pouvez ensuite exporter le tableau affiché en CSV ou Excel.

Dans **Rapports**, choisissez une classe pour limiter les listes d'élèves, les frais impayés, les paiements, les présences, les notes ou les matières à cette classe. **Toutes les classes** affiche la liste complète. **Élèves par classe (A à Z)** trie les élèves par classe, puis par nom et prénom. Le filtre est désactivé pour le rapport **Dépenses**, qui n'est pas lié à une classe.

Dans **Sauvegarde & journal**, vous pouvez enregistrer une copie de la base SQLite, restaurer une sauvegarde validée et consulter les 500 dernières opérations journalisées. Avant une restauration, le logiciel crée une copie de sécurité de la base actuelle.

Dans **Personnel**, ajoutez les enseignants et leurs informations. Dans **Présences**, choisissez la date et la classe, puis enregistrez le statut de chaque élève. Une correction d'une présence déjà saisie demande confirmation et apparaît dans le journal. Les présences peuvent aussi être exportées depuis **Rapports**.

Dans **Matières & notes**, associez des matières aux classes et saisissez les notes par trimestre et année scolaire. L'onglet **Bulletins individuels** permet de choisir une classe, une période et un élève, de consulter ses notes et sa moyenne sur 10, puis de créer le PDF individuel. Les corrections de notes sont confirmées et enregistrées dans le journal.

Dans **Élèves**, modifiez la fiche choisie, archivez-la pour la conserver sans l'utiliser dans les listes courantes, ou supprimez-la définitivement. La suppression définitive demande confirmation et indique le nombre de notes, présences, frais et paiements concernés ; ces données associées sont alors également supprimées, tandis que l'opération reste inscrite dans le journal.

L'application utilise Tkinter et SQLite, inclus dans les installations standard de Python. ReportLab génère les reçus PDF. Au premier lancement depuis le code, le fichier `data/sabiloul_houda.sqlite3` est créé à la racine du projet, même si le code est rangé dans `src`. Dans la version `.exe`, les données sont conservées dans `%LOCALAPPDATA%\SabiloulHouda\data`, séparément du programme.

## Organisation du dossier

```text
sabiloul_houda_logiciel_code/
├── README.md
├── build_windows.bat
├── Sabiloul Houda.spec
├── requirements.txt
├── requirements-build.txt
├── assets/
│   ├── logo_sabiloul_houda_original.jpg
│   ├── logo_sabiloul_houda.png
│   └── logo_sabiloul_houda.ico
├── src/
│   └── main.py
├── data/
│   ├── sabiloul_houda.sqlite3
│   ├── rapports/
│   └── recus/
├── docs/
│   ├── README.md
│   └── livrables/
│       ├── Journal_de_prompts_Sabiloul_Houda_a_completer.docx
│       ├── Soutenance_Sabiloul_Houda.pptx
│       └── Soutenance_Sabiloul_Houda.pdf
├── .vscode/              (configuration de lancement VS Code)
├── build/                (fichiers temporaires de compilation)
└── dist/                 (application Windows compilée)
```

Dans VS Code, ouvrez le dossier `sabiloul_houda_logiciel_code`. Pour démarrer le logiciel, utilisez le terminal intégré à la racine et lancez `python src/main.py`, ou appuyez sur F5 avec la configuration du projet.

Ce dossier est l'unique version active du projet. Les anciens dossiers et les anciennes variantes sont conservés à côté, dans `../archives/versions_precedentes`, et ne font pas partie du projet à présenter. Les trois livrables finaux sont rangés dans `docs/livrables` avec le code pour pouvoir être ajoutés ensemble au dépôt GitHub.

## Principes de données

- Une inscription relie l'élève à une classe et une année scolaire.
- Les paiements sont conservés comme opérations distinctes des frais attendus, afin de pouvoir gérer les paiements partiels.
- Les opérations financières ne sont pas effacées par une action de suppression ordinaire.
- L'année configurée au démarrage est 2026-2027.
- Pour utiliser les mêmes données sur un autre PC, fermez le logiciel et copiez le dossier `data` vers le dossier de l'application sur le nouvel ordinateur.
- Faites régulièrement une copie de sauvegarde de ce fichier sur une clé USB.

## Création de l'application Windows

Sur un PC Windows connecté à Internet, double-cliquez sur `build_windows.bat`. Le fichier `dist\Sabiloul_houda.exe` sera créé avec le logo de l'école. Il inclut Python et les bibliothèques du logiciel ; Python n'aura donc pas besoin d'être installé sur le PC cible. Les données restent dans le profil Windows, dans `%LOCALAPPDATA%\SabiloulHouda\data`. Pour déplacer les données d'un PC à l'autre, créez une sauvegarde dans le logiciel puis restaurez-la sur le nouvel ordinateur.

## Évolution prévue

1. Élèves, responsables, classes et inscriptions.
2. Frais par élève, versements partiels et soldes restants.
3. Reçus PDF et dépenses.
4. Sauvegardes/restauration et journal des opérations.
5. Vérification finale sur Windows 10 et création du fichier `.exe` avec `build_windows.bat`.

Les fonctions doivent être vérifiées sur le PC cible avec des données fictives avant toute utilisation réelle.
