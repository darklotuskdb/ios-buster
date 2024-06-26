# iOS Buster: Automation for iOS Penetration Testing
The iOS Buster is a groundbreaking penetration testing tool for iOS, capable of performing both static and dynamic testing. It provides detailed reports, including STR, highlighting discovered vulnerabilities. It serves as a valuable addition to MobSF.

# Tool Can Pentest The Following Vulnerabilities
```
Application Allows Custom Keyboards On Sensitive Fields
Application Binary Is Not Obfuscated [Need to improve]
Application Minimum OS Version Is Vulnerable
Application Not Disabled Sensitive Data From Being Copied
ARC Not Enabled
ATS Configuration Is Insecure
Biometric Authentication Bypass
Certificate Pinning Bypass
Certificate Pinning Not Implemented
Checking Symbol Information
Improper Application Cookie Policy
Integrity Check Not Implemented On WebView Content
Internal IP Discovered
Jailbreak Detection Bypass
Lack of Authentication After Background Resume
Login Credential Found In Device Memory Dump
Misconfigured Access Origin In Cordova Or PhoneGap
Missing Anti Debugging Mechanism
Missing Security Checks on the Enrollment of Additional Biometrics
No Jailbreak Detection
PIE ASLR Not Implemented
Screenshot Disclosing Sensitive Information
Security Access Control Missing From iOS Keychain
Stack Canaries Not Enabled
Unmasked Sensitive Data
Use Of Insecure Random Function
Use Of Vulnerable Cordova or PhoneGap Framework Version
User Related Data Cached In WebView
User Related Data Captured In System Logs
User Related Data In Devie Local Storage
User Related Data Stored in Device Keychain
User Related Data Stored In Plist
Misconfigured Firebase [Need to improve]
Scanning DeepLinks [Need to improve]
```

# Installation
1. On your laptop, download the latest release of the iOS-Buster tool
   ``` 
   https://github.com/darklotuskdb/ios-buster/releases/latests
   ```

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
    gawk nano unzip coreutils tree libplist-utils cycript lldb darwintools
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
   
   Note: If the application has a PIN login functionality, please avoid using common values like "00000" or "123456". Instead, consider using unique values such as "113377" to prevent false positives in the tool's output.
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/8f5d7d69-23af-431d-a773-f185994ca3a7)

4. In many applications, you will encounter numerous user input fields such as address, comment boxes, support forms, etc. Instead of providing random data in each of these fields, consider using a consistent keyword like 'iOSTest' or 'ipaTest'. You can create your own keyword, For example your name. This approach simplifies the process as you only need to search for one keyword rather than multiple ones.
5. First perform the following test-cases in the order as mentioned below using ``` iOS_Buster-Win.bat ``` and manually. The tool will prompt for the pass or fail status of these test cases in order to include the findings in the Report file generated by the main tool.
   ```
   Jailbreak Detection Bypass
   Lack of Certificate Pinning (iOS)
   Certificate Pinning Bypass
   Application Not Disabled Sensitive Data From Being Copied
   Screenshot Disclosing Sensitive Information 
   Application Allows Custom Keyboards On Sensitive Fields
   Biometric Authentication Bypass
   Missing Security Checks On The Enrollment Of Additional Biometrics
   Unmasked Sensitive Data
   Lack of Authentication After Background Resume
   ```

   Note: Must try the Universal Jailbreak Bypass tool made my @rsbarsania
   ```
   https://github.com/rsbarsania/Universal-JailBreak-Bypass
   ```
6. After completing the aforementioned steps, log out from the application and wait for at least 10 minutes. Then, utilize the iOS_Buster-Win.bat script on Windows to perform keychain and memory dump.

   Note: "Utilize 'iOS_Buster-Win.bat' to generate these two files. It's crucial that the filenames remain the same; otherwise, the tool might overlook findings. If you're manually creating them, ensure proper naming convention by using all lowercase letters. For the keychain file, the name must be 'keychain.json', and for the memory dump file, it must be 'strings.txt'.
   
   ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/6ad1e8ed-5456-4073-9e26-616bcde60070)

8.  For the ``` keychain.json ``` file, select the option "2" and provide the application ``` Identifier ``` from the Frida output.
9.  For the ``` strings.txt ``` file, select option "6" and provide the application ``` Name ``` (without double/single quotes) from the Frida output.
10.  Now on your laptop, create a directory with any name. Let's say the application name is 'DVIA v2'. Then, simply create a folder named 'dvia'. Inside the 'dvia' folder, create a file named ``` keywords.txt ```. Additionally, create a folder named ``` input ``` and copy the ``` keychain.json ``` file and ``` strings.txt ``` file inside the ``` input ``` folder.

     Note: Ensure that every file or folder name is in lowercase letters.
     
       ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/4e3721ab-c2e4-4f8a-9c19-59b023a3c3b4)
11. Open the ``` keywords.txt ``` file in a text editor like Notepad, and input all sensitive data as keywords for the searching process, such as username, password, email, pin, etc.
   
    Note: Be very careful when adding data in the 'keywords.txt' file. Ensure there are no empty lines, especially at the end. Sometimes, the application URL-encodes special characters, so make sure to repeat the keyword by converting it into URL-encoded form. For example, as shown in the image below, 'Password@123' is provided and repeated by URL encoding the '@' symbol, making it 'Password%40123'.

      ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/5bc5806f-48c5-4de7-bfa0-2d9e0b5c0040)
   
12. Using 3utools, just drag and drop the ``` dvia ``` folder in the ``` applications ``` folder present in the ``` iOS ``` directory of the iOS Buster tool.

      Note: 'a-sample-folder' directory is present inside the 'applications' directory for your reference, providing information on the necessary files and folders.

      ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/c83a3977-0691-43df-9244-972f08a47adf)

13. Now we are all set to execute our iOS Buster tool. 
   Launch the target application, in our case, it is 'DVIA v2', but do not log in. Connect the iOS device via SSH and execute the following command: ``` ios-buster.sh -a "<app-name>" -d applications/<folder-name> ```

    ```
    ./ios-buster.sh -a dvia -d applications/dvia
    ```

    ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/447ca84b-fb3e-4ba2-ad4e-e0e7e2e9615f)

14. The following pop-up will appear on your iOS device screen once the iOS Buster starts the penetration test.
    ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/e36b0cc4-24e4-4be1-939e-2275fdf75a09)

15. The tool will cover more than 30 test cases, including both static and dynamic assessments, in less than 2 minutes. Additionally, it will provide a report detailing all discovered vulnerabilities.
      ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/d3953350-05af-4ab8-a7ed-b679b3152986)

16. Export the Logs-<app-name>.zip folder from the "app-name" directory present inside the "applications" folder of the iOS Buster tool. These files contain all the detailed logs of the tool scan activities. Additionally, the best part is that you will receive a ``` report ``` of all the findings, including vulnerability descriptions, locations, steps to reproduce, and remediation for all the discovered issues, saving a lot of time.

    ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/280556e2-5210-41e7-8f05-ed8d4029cab6)

    ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/17aae5d8-f1e7-44a2-a417-c88859dc0394)

    ![image](https://github.com/darklotuskdb/ios-buster/assets/29382875/a960b636-1680-4ded-8c1b-fb5d776f270b)

17. In the report file, i.e. ``` 3-Report.txt ```, you have to select the value and perform a 'replace all' operation. For example, just copy the "<----IPA-File---->" placeholder and replace it with the IPA target application file name. This value will then be updated in all the STRs. Similarly, repeat the process for other placeholders.

# Note
This tool is still under development and is intended solely for ethical hackers to conduct white hat security penetration testing. If you misuse this tool, I will not be responsible for any consequences. Please inform me if you encounter any errors while using it, and also suggest additional findings to include in this tool.

# About Me

* **DarkLotus** - *Cyber Security Researcher* - [DarkLotusKDB](https://github.com/darklotuskdb)

### Social Media Handles
* [Twitter](https://twitter.com/darklotuskdb)
* [Medium](https://medium.com/@darklotus)
* [Linkedin](https://www.linkedin.com/in/kamaldeepbhati/)
* [Instagram](https://www.instagram.com/kamaldeepbhati/)

[BuyMeACoffee](https://www.buymeacoffee.com/darklotus) If you like my work <3

