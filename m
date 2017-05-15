From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 15 May 2017 18:12:46 +0800
Subject: [PATCH v2] ARM: at91/defconfig: add MCAN driver to sama5_defconfig
Message-ID: <20170515101246.8913-1-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Controller Area Network (MCAN) driver compilation
for sama5 default configuration. Is used by sama5d2 SoC for instance.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2:
 - Rebase on Linux-4.12-rc1.

 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 777c9e986425..01f7dedd570d 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -52,6 +52,7 @@ CONFIG_IP_PNP_RARP=y
 CONFIG_IPV6_SIT_6RD=y
 CONFIG_CAN=y
 CONFIG_CAN_AT91=y
+CONFIG_CAN_M_CAN=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
-- 
2.11.0
