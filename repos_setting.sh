cd ${HOME}

sudo apt update -y && sudo apt install curl -y
sudo curl -sSL http://archive.hark.jp/harkrepos/public.gpg -o /usr/share/keyrings/hark-archive-keyring.asc

if [ "$(lsb_release -i | awk '{print $3}')" = "Ubuntu" ] ; then
    sudo bash -c 'echo -e "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hark-archive-keyring.asc] http://archive.hark.jp/harkrepos $(lsb_release -cs) non-free\ndeb-src [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hark-archive-keyring.asc] http://archive.hark.jp/harkrepos $(lsb_release -cs) non-free" > /etc/apt/sources.list.d/hark.list'
    echo "成功"
elif [ $(lsb_release -cs) = "bullseye" ] ; then
    sudo bash -c 'echo -e "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hark-archive-keyring.asc] http://archive.hark.jp/harkrepos focal non-free\ndeb-src [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hark-archive-keyring.asc] http://archive.hark.jp/harkrepos focal non-free" > /etc/apt/sources.list.d/hark.list'
    echo "成功"
else
    read -p "Debian の "$(lsb_release -cs)" に対応する Ubuntu のバージョン名を、半角英字で入力してください。" uName
    sudo bash -c 'echo -e "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hark-archive-keyring.asc] http://archive.hark.jp/harkrepos ${uName} non-free\ndeb-src [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hark-archive-keyring.asc] http://archive.hark.jp/harkrepos ${uName} non-free" > /etc/apt/sources.list.d/hark.list'
    echo "書き込み完了"
fi

echo 再起動します。
sudo reboot