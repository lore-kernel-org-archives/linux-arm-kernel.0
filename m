From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Mar 2015 14:48:31 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable Bluetooth support
Message-ID: <1426268911-6574-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Enable Bluetooth over serial support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cf1e71e..6aa0256 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -71,6 +71,9 @@ CONFIG_IPV6=y
 CONFIG_NETFILTER=y
 CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
+CONFIG_BT=y
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_3WIRE=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_RFKILL=y
-- 
1.9.1
