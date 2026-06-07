#!/data/data/com.termux/files/usr/bin/bash

echo "================================="
echo "     DNS FINDER ULTRA PRO MAX"
echo "================================="
echo

read -p "Domínio: " DOMAIN

echo
echo "[*] A analisar $DOMAIN..."
echo

IPV4=$(dig +short A "$DOMAIN" | head -n1)
IPV6=$(dig +short AAAA "$DOMAIN")
NS=$(dig +short NS "$DOMAIN")
MX=$(dig +short MX "$DOMAIN")
TXT=$(dig +short TXT "$DOMAIN")
WHOIS=$(whois "$DOMAIN" | head -n 20)

echo "[+] IPv4: $IPV4"
echo "[+] IPv6: $IPV6"
echo "[+] NS: $NS"
echo "[+] MX: $MX"

echo
echo "[+] Gerando painel HTML..."

cat > painel.html <<EOF
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ULTRA PRO DNS PANEL</title>
<style>
body {background:#0a0f1f;color:#fff;font-family:Arial;padding:20px;}
h1 {color:#00d4ff;text-align:center;}
.box {background:#121a33;padding:15px;margin:10px 0;border-radius:10px;}
.title {color:#4dd0ff;font-weight:bold;margin-bottom:5px;}
pre {white-space:pre-wrap;}
.status {color:#00ff88;}
</style>
</head>
<body>

<h1>DNS FINDER ULTRA PRO MAX</h1>

<div class="box">
<div class="title">🌐 DOMÍNIO</div>
<pre>$DOMAIN</pre>
</div>

<div class="box">
<div class="title">📡 IPv4</div>
<pre>$IPV4</pre>
</div>

<div class="box">
<div class="title">📡 IPv6</div>
<pre>$IPV6</pre>
</div>

<div class="box">
<div class="title">🛰 NS</div>
<pre>$NS</pre>
</div>

<div class="box">
<div class="title">📬 MX</div>
<pre>$MX</pre>
</div>

<div class="box">
<div class="title">🔐 TXT</div>
<pre>$TXT</pre>
</div>

<div class="box">
<div class="title">📄 WHOIS</div>
<pre>$WHOIS</pre>
</div>

</body>
</html>
EOF

echo
echo "[+] Painel criado com sucesso!"
echo "[+] Abrindo..."

termux-open painel.html
