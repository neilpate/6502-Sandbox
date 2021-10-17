# 6502-Sandbox

Some simple LabVIEW code to help me get to understand the MOS 6502.

I have a 6502 running on a breadboard and the Address bus, Data bus, R/W line and Clock line connected to several NI USB DAQ devices. The LabVIEW code is responsible for generating the clock signal (very slowly!) and mimicing a EEPROM/RAM over the full 64K address space.

As the ROM is being simulated this makes it very easy to write some assembly and run it without actually programming an EEPROM.

![Alt text](Resource/Pictures/Photo 1.jpg?raw=true "Title")
