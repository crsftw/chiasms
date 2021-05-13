# Chiasms
Chia network and wallet statistics monitoring script for Linux.<br>
Designed to be executed after each user BASH login.<br>

**Installation**:<br>
git clone <br>
Append the file path at the end of the ~/.bashrc.<br>
**Example:**<br>
/home/my_username/chia-status.sh<br>
**Give the script execution permissions**:<br>
chmod +x ./chia-status.sh<br>

Logout of the SSH session and log back in. </code><br>

Tested in Debian 10.9.0 x64.<br>
The script assumes that the Chia install folder is called "chia-blockchain", searches for it and detects its location.<br>

**Known issues**:<br>
- it slow (~4 seconds)<br>
- it's not yet optimized.<br>
