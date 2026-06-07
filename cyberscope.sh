#!/data/data/com.termux/files/usr/bin/bash

clear

# ================= CORES =================
G="\e[32m"
B="\e[34m"
Y="\e[33m"
C="\e[36m"
R="\e[31m"
W="\e[97m"
N="\e[0m"

# ================= HEADER =================
echo -e "${C}╔════════════════════════════════════╗${N}"
echo -e "${C}║          CYBERSCOPE ULTRA          ║${N}"
echo -e "${C}║     DOMAIN INTELLIGENCE TOOL      ║${N}"
echo -e "${C}╚════════════════════════════════════╝${N}"
echo

read -p "🌐 Domínio: " DOMAIN

echo
echo -e "${Y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${G}🔎 ANALISANDO: ${W}$DOMAIN${N}"
echo -e "${Y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"

# ================= DNS =================
IPV4=$(dig +short A "$DOMAIN" | head -n1)
IPV6=$(dig +short AAAA "$DOMAIN")
NS=$(dig +short NS "$DOMAIN")
MX=$(dig +short MX "$DOMAIN")
TXT=$(dig +short TXT "$DOMAIN")
CNAME=$(dig +short CNAME "$DOMAIN")
SOA=$(dig +short SOA "$DOMAIN")

# fallback
[ -z "$IPV4" ] && IPV4="N/A"

# ================= REVERSE DNS =================
REV="N/A"
if [ "$IPV4" != "N/A" ]; then
    REV=$(dig +short -x "$IPV4")
fi

# ================= HTTP =================
HTTP=$(curl -I -s --max-time 5 https://$DOMAIN 2>/dev/null)
[ -z "$HTTP" ] && HTTP=$(curl -I -s --max-time 5 http://$DOMAIN 2>/dev/null)
[ -z "$HTTP" ] && HTTP="SEM RESPOSTA HTTP"

# ================= SSL =================
SSL="N/A"
if command -v openssl >/dev/null 2>&1; then
    SSL=$(echo | openssl s_client -connect "$DOMAIN:443" -servername "$DOMAIN" 2>/dev/null \
    | openssl x509 -noout -issuer -subject -dates)
fi

# ================= PING =================
PING="N/A"
if [ "$IPV4" != "N/A" ]; then
    PING=$(ping -c 3 "$IPV4" 2>/dev/null)
fi

# ================= IP INFO =================
IPINFO="N/A"
if [ "$IPV4" != "N/A" ]; then
    IPINFO=$(curl -s --max-time 5 http://ip-api.com/json/$IPV4 2>/dev/null)
fi

# ================= WHOIS =================
WHOIS=$(whois "$DOMAIN" 2>/dev/null | head -n 20)
[ -z "$WHOIS" ] && WHOIS="SEM WHOIS"

# ================= OUTPUT STYLE =================

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ IP ADDRESS        ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "IPv4 : ${G}$IPV4${N}"
echo -e "IPv6 : ${G}$IPV6${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ NAMESERVERS       ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$NS${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ MAIL (MX)         ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$MX${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ TXT RECORDS       ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$TXT${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ CNAME             ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$CNAME${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ SOA               ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$SOA${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ REVERSE DNS       ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$REV${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ PING              ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$PING${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ HTTP HEADERS      ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$HTTP${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ SSL CERT          ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$SSL${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ IP INFO           ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$IPINFO${N}"

echo
echo -e "${C}╔════════════════════╗${N}"
echo -e "${C}║ WHOIS             ║${N}"
echo -e "${C}╚════════════════════╝${N}"
echo -e "${G}$WHOIS${N}"

# ================= FINAL =================
echo
echo -e "${Y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${G}✔ SCAN FINALIZADO CYBERSCOPE ULTRA${N}"
echo -e "${Y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
