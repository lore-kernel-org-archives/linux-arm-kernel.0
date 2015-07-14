From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 14 Jul 2015 10:49:46 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_IKCONFIG_PROC
Message-ID: <1436881786-9886-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is useful to know how the kernel was configured via:
zcat /proc/config.gz ,so select the CONFIG_IKCONFIG_PROC option.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e1ba3e2..a4ebc95 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -3,6 +3,8 @@ CONFIG_SYSVIPC=y
 CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUPS=y
 CONFIG_RELAY=y
@@ -76,8 +78,8 @@ CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_HCIUART=y
-CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_H4=y
+CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_RFKILL=y
-- 
1.9.1
