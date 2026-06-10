# AGENTS.md — road-to-six

road-to-six est un **méta-défi d'accountability**, pas un atelier de code : un manifeste
(`README.md`), un dashboard de statuts (`PROJECTS.md`), un sous-dossier par projet suivi (un
`JOURNAL.md`, parfois une spec `MVP.md`). **Le code des projets suivis vit ailleurs**, dans des
repos GitHub séparés — on n'y touche jamais d'ici.

## Régime métabolique — les règles gravées

1. **Jamais de purge. On promeut.** Une ligne projet se promeut le long de son cycle de vie
   (`🌰 Seed → 🌱 Germinating → 🌿 Growing → 🚀 Released → ✅ Shipped`, ou `🪦 Abandoned`) ; elle ne
   se supprime jamais. Le statut affiché est le **jalon le plus avancé atteint**, pas l'activité du
   moment (l'activité, c'est le `JOURNAL` qui la porte). La taxonomie complète vit dans
   [`PROJECTS.md`](./PROJECTS.md).

2. **Le mot « MVP » est mort. Les objectifs se figent dans un `README.md` par projet.** Chaque
   sous-dossier projet porte un **`README.md`** — la **barre** (definition of done, _frozen_) plus
   un **scorecard** daté (complétion `%`, complexité, statut, note humaine) — et un `JOURNAL.md`,
   le log. La **definition of done reste figée** comme trace d'accountability ; seul le scorecard,
   daté, peut évoluer. Un objectif d'origine pas encore fait **n'est pas atteint** (il baisse le
   `%`) ; ce qui dépasse l'idée d'origine va en section _Beyond_, **hors `%`**. La spec/intention
   d'un projet **non encore construit** migre vers `_INCUBATOR/` (racine MBP) **au démarrage** —
   graine de brainstorm, **déplacement et non delete** — et **jamais rétroactivement** pour un
   projet déjà sorti. Les projets encore `🌰 Seed` gardent leur ancien `MVP.md` jusqu'à ce vrai
   démarrage.

3. **Manifeste + journaux = immuables.** On **ajoute** au manifeste racine (`README.md`) et aux
   `JOURNAL.md` ; on ne réécrit pas l'historique. `PROJECTS.md` (le dashboard, un snapshot vivant)
   et le **scorecard** des `README.md` de projet (daté) s'éditent librement pour refléter le réel —
   leur definition of done figée, elle, ne bouge pas.

4. **Nommage `AAAA-{défi}/`.** L'année _est_ la date de naissance ; l'identité publique du repo
   prime.

5. **road-to-six suit « ce que je construis / apprends en 2026 »**, pas une liste figée au
   lancement. Un projet non prévu au départ a toute sa place (précédents : `pif-is-fake`,
   `grimoire-arch`).

6. **Le code applicatif vit dans des repos séparés.** Ici : uniquement manifeste / dashboard /
   journaux / specs. On ne convertit ni ne touche le code des projets suivis.

## Ce qu'on ne fait PAS

- ❌ **Pas de `harness-up` ici.** road-to-six n'a aucune surface de vérification (pas de build, pas
  de tests) et la doctrine l'en exempte exprès. La discipline de l'atelier vit _dans chaque projet_,
  pas dans le tableau de bord.
- ❌ Aucune **suppression** de ligne ni de sous-dossier (régime métabolique).
- ❌ Aucune **réécriture** du manifeste ni des journaux (ajout seulement).
- ❌ On ne **duplique** pas la doc d'un projet sorti — on **référence** son repo / son site.
