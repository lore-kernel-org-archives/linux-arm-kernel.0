From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Sep 2015 15:25:11 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: Enable PBIAS regulator
Message-ID: <1441274111-18049-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PBIAS regulator is required for MMC module in OMAP2, OMAP3, OMAP4,
OMAP5 and DRA7 SoCs. Enable it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fd8df6..f497c96 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -403,6 +403,7 @@ CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_PALMAS=y
+CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
-- 
1.7.9.5
