![Tesser_logo](https://docs.google.com/drawings/d/e/2PACX-1vT26NziYMaLrGHlvNspiJ9dOjXR6hZyVxrGwfkgV1MwvMTWtAWh5ZUqMsit5gSllXemcGajjddqfqnc/pub?w=131&h=129)

# TesserAkt

[Objects](https://bitbucket.org/AdrianArtacho/workspace/projects/TESSER) within the *TESSER* environment are designed for real-time interaction. This environement is developed and mantained by [Adrian Artacho](https://bitbucket.org/AdrianArtacho/).

---

# To-Do

- **[Tesser_cmd]** reading from a spreadsheet ([download-sheet]), specific combinations of midinotes cause a specific midi command out. For example: *Midinotes 60 61 63* (played simulteneusly) change the */PRESET* (CC21) to *5*.

- **[Tesser_recall]** a device that could save gestures as presets (and could receive them dynamically from the [Tesser_gesture] device), and do so in their original form, reversed backwards, inverted along a /centernote, inverted along the gesture's axis, 2x tempo 0.5x tempo (Zeitlupe)... etc. The device should ALSO read the contents of the current midi clip playing on its track, as an alternative way of entering gesture info / perform operations on that midi material.

- **[Tesser_fade]** fades in/out: reduces the midi velocities of the inputted notes over time. Obviously, when the velocitites reach zero, no notes get sent out.

- [Tesser_mirror], in THRU mode can be used to set a threshold (upper or lower) for the inputted notes. **[Tesser_threshold]** would do the same for the velocities

- **[Tesser_Mutate]** takes in midi or gesture strings and introduces *mutations*, variations (which can be set to be 1 in x notes, 1 in x seconds... etc.)

- Rename the other repos called TesserAkt, including the Live sets, which do not have anything to do with the current meaning of TesserAkt now...
