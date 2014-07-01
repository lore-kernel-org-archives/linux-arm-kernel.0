From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Tue,  1 Jul 2014 13:09:02 +0200
Subject: [PATCH v2 5/5] ARM: imx_v6_v7_defconfig: Enable flexcan driver for
 can support
In-Reply-To: <cover.1404212584.git.silvio.fricke@gmail.com>
References: <cover.1404212584.git.silvio.fricke@gmail.com>
Message-ID: <03879c318daa89d1e010a2bbd3c286f32b416886.1404212584.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index c331de8..4283393 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -69,6 +69,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_NETFILTER=y
+CONFIG_CAN=y
+CONFIG_CAN_FLEXCAN=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_RFKILL=y
-- 
2.0.0
