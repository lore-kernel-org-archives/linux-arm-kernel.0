From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 15 May 2013 00:53:34 +0000
Subject: [PATCH] ARM: kirkwood: enable Sheevaplug DT in defconfig
In-Reply-To: <1368479941-10084-11-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-11-git-send-email-gmbnomis@gmail.com>
Message-ID: <1368579214-11532-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Just a heads up I'm adding this to the mvebu/defconfig tree.  v3.10-rc1 changed
a few things for defconfig, but it's so little, I'm not worrying about breaking
it out.

 arch/arm/configs/kirkwood_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index a1d8252..1916da6 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -1,4 +1,3 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -50,6 +49,7 @@ CONFIG_MACH_NETSPACE_V2_DT=y
 CONFIG_MACH_NSA310_DT=y
 CONFIG_MACH_OPENBLOCKS_A6_DT=y
 CONFIG_MACH_READYNAS_DT=y
+CONFIG_MACH_SHEEVAPLUG_DT=y
 CONFIG_MACH_TOPKICK_DT=y
 CONFIG_MACH_TS219_DT=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
@@ -68,14 +68,12 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
-CONFIG_NET_DSA=y
 CONFIG_NET_PKTGEN=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
-- 
1.8.2.1
