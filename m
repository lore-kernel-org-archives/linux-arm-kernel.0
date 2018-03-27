From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 27 Mar 2018 21:21:09 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and
 CONFIG_SNI_AVE
Message-ID: <1522153269-21244-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the thermal monitor driver and the AVE ethernet driver
implemented on UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c1e045a..8c923ec 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -262,6 +262,7 @@ CONFIG_KS8851=y
 CONFIG_R8169=y
 CONFIG_SH_ETH=y
 CONFIG_SMSC911X=y
+CONFIG_SNI_AVE=y
 CONFIG_STMMAC_ETH=y
 CONFIG_STMMAC_PLATFORM=y
 CONFIG_DWMAC_DWC_QOS_ETH=y
@@ -479,6 +480,7 @@ CONFIG_ARMADA_THERMAL=y
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_EXYNOS_THERMAL=m
 CONFIG_ST_THERMAL_MEMMAP=y
+CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
 CONFIG_XILINX_WATCHDOG=y
-- 
2.7.4
