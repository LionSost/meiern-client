COBOL Maexchen Client
============

A dummy implementation of a Maexchen Client in COBOL.

Content
----------
- **CLIENT.cbl** A helper module to communicate with the Maexchen server
  Can be compiled with:
  ```bash
  cobc +x -I copy CLIENT.CBL
  ```
- **DUMMBOT.cbl** A stupid bot that always rolls and always announces the rolled dice.
- **SIMPLBOT.cbl** A more elaborate version of the DUMMBOT.cbl.
