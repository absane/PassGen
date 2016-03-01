This uses PassGen from [here](https://github.com/Broham/PassGen) to generate a list of common passwords one might see outside of the usual letmein or password1. Instead, the focus of this is to generate passwords like $Company$$year%, $Season$123, etc. The idea came from [Chris Gates: Pentesting from "LOW" to "PWNED"](https://www.youtube.com/watch?v=u68QvWXYW_Q) talk.

Output of the results is pass.txt.

##Uasge
./custom_pass_list.sh # generates a standard list of passwords based on input Useful for remote RDP services.

./custom_pass_list.sh <any argument> # will generate an extended list of passwords. Useful for WiFi/AD cracking.
