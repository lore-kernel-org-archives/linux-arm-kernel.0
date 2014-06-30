From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Mon, 30 Jun 2014 15:28:09 +0200
Subject: [PATCH 5/5] ARM: imx_v6_v7_defconfig: Enable flexcan driver for can
 support
In-Reply-To: <cover.1404132504.git.silvio.fricke@gmail.com>
References: <cover.1404132504.git.silvio.fricke@gmail.com>
Message-ID: <9816fbb23593185b711c1fe32836ec5b763b688d.1404132504.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index c331de8..88877226 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -69,6 +69,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_NETFILTER=y
+CONFIG_CAN=m
+CONFIG_CAN_FLEXCAN=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_RFKILL=y
-- 
2.0.0
