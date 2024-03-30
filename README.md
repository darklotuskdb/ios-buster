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
7. Execute the following command to unzip the contents:
   ```
   unzip iOS-Buster*.zip
   ```
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/8469b545-0b0f-4e73-90ea-f16738dd4e33)
8. Execute the following commands to give the executable permission:
   ```
   cd iOS-Buster-KDBhati/iOS
   ```
   ```
   chmod +x *.sh
   ```
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/86a83755-01df-468d-b00b-33db9c300531)
9. We need some tools to be installed before running the iOS Buster tool as listed below:
    ```
    gawk nano unzip coreutils tree libplist-utils cycript lldb
    ```
    To install these tools run the Install-Setup.sh file:
      ```
      ./Install-Setup.sh
      ```
10. The tool is ready to use now. Check the Usage section to get proper instructions:
    ```
    ./ios-buster.sh
    ```
    ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/c1ad30a8-8422-4d93-a493-f64fd16573e9)

# Usage
1. Install the target application you want to pentest using the iOS Buster tool, or alternatively, use 3uTools to install the IPA file.
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/b61c5475-a3b0-4853-bcae-13b85ba8e5dc)

2. Launch the application and thoroughly navigate through all functionalities, including submitting forms and updating items such as user profile picture, change password, etc. This action is essential for generating data in both the device's local storage and system logs, thereby facilitating improved output from the tool. These steps are critical, as approximately 90% of dynamic test cases rely on this process. Failure to properly navigate the application may result in data not being stored in the local storage.
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/8f5d7d69-23af-431d-a773-f185994ca3a7)

3. In many applications, you will encounter numerous user input fields such as address, comment boxes, support forms, etc. Instead of providing random data in each of these fields, consider using a consistent keyword like 'iOSTest' or 'ipaTest'. You can create your own keyword, For example your name. This approach simplifies the process as you only need to search for one keyword rather than multiple ones.
4. Once

   
