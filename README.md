TragDate's Rice
Dependecies : Minimal Arch Installation

TragDate is using blackarch repos so here is what you need to do to enable them too :

[YOU NEED MULTILIB ENABLED FOR THIS!!!]

1. Run this command `curl -O https://blackarch.org/strap.sh`
2. If it went well you should see `OK` in terminal you can see that by typing `echo 26849980b35a42e6e192c6d9ed8c46f0d6d06047 strap.sh | sha1sum -c`
3. Now you need to make the `strap.sh` an executable script by typing `chmod +x strap.sh`
4. Run the script `sudo ./strap.sh`

If you have no errors is done 
if you do have errors scroll down!!
   
5. If you get an error like this :
![pic-selected-240827-0109-31](https://github.com/user-attachments/assets/89b9ee0e-c6e8-4dd7-a9f8-2068619da616)
You need to `sudo vim /etc/pacman.conf` Go to the very last line and you should see `[blackarch]`
you need to type `Server = https://md.mirrors.hacktegic.com/blackarch/$repo/os/$arch`
Run the script once again `sudo ./strap.sh`
And you should get no errors now!

For the Firefox CSS you need to:
1. Go to the search bar and type `about:config` after that search for `toolkit.legacyUserProfileCustomizations.stylesheets` and click on it and it should show `true`.
2. Go to the search bar and type `about:profiles` and click on `Root Directory` on the `Open Directory` button
3. Make a folder called `chrome`
4. Drag the `userChrome.css` into the `chrome` folder
5. Done!  
