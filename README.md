# MUSE-Cues
Cues for MUSE.

## Notes
Qlab/EOS
UDP, localhost, 8000

Animatronic Notes
Animation | Midi Channel | Note | Velocity
--- | --- | --- | ---
K4 | 1 | 1 | 30
D1 - M | 2 | 10 | 10
D2.5 - M | 2 | 20 | 20
D2 - M | 2 | 25 | 25
D3 - M | 2 | 30 | 20
D4 - M | 2 | 40 | 40
D1 - L | 3 | 10 | 10
D2 - L | 3 | 20 | 20
D2.5 - L | 3 | 25 | 25
D3 - L | 3 | 30 | 20
D4 - L | 3 | 40 | 40
A1 - M | 4 | 10 | 10
A2 - M | 4 | 20 | 20
A3 - M | 4 | 30 | 20
A4 - M | 4 | 40 | 40
A5 - M | 4 | 50 | 50
A6 - M | 4 | 60 | 60
A1 - L | 5 | 10 | 10
A2 - L | 5 | 20 | 20
A3 - L | 5 | 30 | 20
A4 - L | 5 | 40 | 40
A5 - L | 5 | 50 | 50
A6 - L | 5 | 60 | 60

## Arm Notes

**Find USB ports:**
```bash
.venv/bin/lerobot-find-port
```

**Teleoperate both arms (leader + follower):**
```bash
.venv/bin/lerobot-teleoperate \
  --teleop.type so101_leader \
  --teleop.port /dev/tty.usbmodem5AE60586551 \
  --robot.type so101_follower \
  --robot.port /dev/tty.usbmodem5AE60541051
```

**Teleoperate single arm (keyboard control):**
```bash
.venv/bin/lerobot-teleoperate \
  --teleop.type keyboard \
  --robot.type so101_follower \
  --robot.port /dev/cu.usbmodem5AE60541051
```

## Archive script
Run `./make_archive.sh` to zip the listed files into Archive/ using a timestamped name.

## Lighting cues import script
Run the script using the apple interpolator

## Change log
### 2026-02-20
EOS:
-- all lighting ques built

Qlab:
-- line placed in Qlab

### 2026-02-20
EOS:
-- Focused lights 
-- filled all pallets
-- built cue 1 through 406 (general and single object)

### 2026-02-14
QLab:
-- build control cart for ease of use

EOS: 
-- changed number of fixtures from 6 to 8 

### 2026-02-13
Qlab:
- lighting script imports correctly into qlab
- main que stack outlined with all ques (lighting, sound, anamtronic)
- built control stack to enable which configuration 

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

