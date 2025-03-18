# So I've scratched BB JDE to write BBOS 5.0 Apps for my 9700...  

## Disclaimer  

This project is an open-source effort to support development for BlackBerry OS 5.0. It is **not** affiliated with, endorsed by, or sponsored by BlackBerry Limited or any of its subsidiaries. All trademarks, logos, and brands mentioned in this repository are the property of their respective owners. The use of "BlackBerry OS," "BB," and related terms in this project is for informational and developmental purposes only.  

By contributing to this project, you acknowledge that you do not hold any ownership or rights to the BlackBerry brand or its intellectual property. All rights to the BlackBerry brand and related products are owned by BlackBerry Limited.  

## Disclaimer [1]  

This is tailored for my personal use. It may change or disappear altogether. Do not rely on it—tread lightly.  

## TL;DR  

Run the BB JDK on Linux with Wine to write some stuff for the BlackBerry Bold 9700.  

## What is it?  

This repo contains my footnotes describing the necessary steps for:  

- Learning about BlackBerry development  
- Learning about Windows XP (the BB JDE was first run by me on an IBM ThinkPad R32 to prove that it works)  
- Advancing my knowledge of Windows systems in general  
- Learning about Java  
- Eventually reducing tool usage down to:  
  - Importing necessary JARs from JDE  
  - Developing in an IDE-agnostic environment  
  - Using Wine only for compilation and simulation (I am now just one command-line call away from getting from code to my app running on the simulated device)  

## What could it be?  

Maybe in the future:  
- Links to the JDK used (if requested)  
- Dependencies  
- An installation guide  

As of the first push, I have already revised some things and will try to keep it updated.  

## Notes  

To prepare Wine, I suggest:  
- Creating a separate `WINEPREFIX` directory  
- Applying the registry changes (`regs` directory)  
- Possibly tweaking it further  
- Checking the `misc` directory to understand my setup (it's a bit of an abomination)  
- Ignoring `i3wm_*` stuff unless you’re into that kind of thing  

## P.S.  

If you've made it this far and still have questions, feel free to DM me. I'll be happy to share my experience—my wife can't stand hearing about it anymore.  
