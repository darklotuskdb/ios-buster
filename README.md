# iOS-Buster
The iOS Buster is a groundbreaking penetration testing tool for iOS, capable of performing both static and dynamic testing. It provides detailed reports, including STR, highlighting discovered vulnerabilities. It serves as a valuable addition to MobSF.

# Installation
1. On your laptop, download the latest release of the iOS-Buster tool
   ``` 
   https://github.com/darklotuskdb/ios-buster/releases/latests
   ```
   Note: If you have downloaded it on your laptop, then use 3uTools () to transfer the tool's zip file to your iOS device.

2. Download 3uTools from the below link:
   ``` 
   https://www.3u.com/productsWin
   ```
3. Click on the 'Files' option located in the bottom-left corner of the iDevice section (landing page) in 3uTools.
4. Click on 'File System (User)', then select 'Downloads' and drag-and-drop the tool's zip file into the downloads directory.
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/8570b659-48e7-4c70-9016-391bde40416c)
5. In the 'ToolBox' section of 3uTools, search and enable the SSH Tunnel.
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/76e3b6b8-52a4-4183-8778-1a5dc44202d2)
6. Launch Windows CMD and execute the following command to connect via SSH:

   Note: Avoid using the Putty SSH client via 3uTools. In that terminal, the history is limited, and scrolling may be improper, leading to potential loss of initial output.
   ```
   ssh root@127.0.0.1
   ```
   Note: If you get an error while connecting such as ``` WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED! ``` then simply go to the ``` C:\Users\<username>\ ``` and delete the ``` .ssh ``` folder and then try to reconnect.
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/67e68621-bdb9-4d40-94aa-e93a9245ff18)
