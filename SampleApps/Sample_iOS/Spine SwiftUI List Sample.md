# Spine SwiftUI List Sample

## General

The `ListViewController` loads the `SpineMetalStack` and all skeletons once and holds them in memory.

The list cycles though all skeletons and chooses a random animation.

The list cells are reused and only initialize the sine view once.

On cell appearence the previous skeleton is removed and the new one added.

Animation is starte on entering the viewport and paused when leaving.

## Observations

- Needed to append `-pro` to atalas tiles and add `txt` file extensions
- Cannot add `-ess` and `-pro`, as always a coresponding atlas containing same substing is expected
  - Just cpied the atlas and renamed it accordingly
- Some crashes with atachments and attachment types when loading samples `dragon` and `stretchyman`
- Goblins sample does not seem to load all elements

## Performace

Run on iPhone 13 PRO

- CPU 30%
- Memory ~200-250MB
- Very High Energy Impact
- 75% GPU