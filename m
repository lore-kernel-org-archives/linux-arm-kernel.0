From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Fri, 9 Nov 2018 02:01:13 +0100
Subject: [PATCH v3 3/9] arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
In-Reply-To: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Message-ID: <189efc09-0863-11b5-2983-f27530176307@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")
folded NF_CONNTRACK_IPV4 and NF_CONNTRACK_IPV6 into NF_CONNTRACK.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8d6878c1e794..58741c07a6ef 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -156,14 +156,12 @@ CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m
 CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
-- 
2.8.2
