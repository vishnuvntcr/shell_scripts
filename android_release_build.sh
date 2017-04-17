read -p "Enter Application name: " app_name
read -p "Enter release key name: " key_name
read -p "Enter release key alias name: " alias_name
read -p "Enter validity (in days): " validity

cordova plugin rm cordova-plugin-console

cordova build --release android

keytool -genkey -v -keystore "$key_name.keystore" -alias $alias_name -keyalg RSA -keysize 2048 -validity 10000

jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore "$key_name.keystore" android-release-unsigned.apk $alias_name -tsa http://timestamp.digicert.com

zipalign -v 4 android-release-unsigned.apk "$app_name.apk"