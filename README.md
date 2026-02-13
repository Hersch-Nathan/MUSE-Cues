# MUSE-Cues
Cues for MUSE.

## Notes
Qlab/EOS
UDP, localhost, 8000

## Archive script
Run `./make_archive.sh` to zip the listed files into Archive/ using a timestamped name.

## Lighting cues import script
Run the script using the apple interpolator

## Change log
### 2026-02-12
Qlab:
- build midi ques for animatronic
- build main que stack and built 4 ques for sm
- working on importing lighting into qlab

### 2026-02-11
Updated *cue.csv file generator:
- changed lighting_cues to eoslightingcues.csv
- added palettes used in each cue in eoslightingcues.csv
- created qlablightingcues.csv to map qlab q to eos q

Qlab: 
- configured sound patch
- confirmed it works on show computer


### 2026-02-10
Qlab:
- Added network connection for EOS on the same device.
- Added a preshow light cue as an example.

EOS:
- Patched fixtures.
- Created all color and intensity palettes.

