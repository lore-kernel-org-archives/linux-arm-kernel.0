From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 14 Dec 2012 11:02:57 +0530
Subject: [PATCH v2 1/8] ARM: OMAP2+: omap2plus_defconfig: Enable tps65217 PMIC
In-Reply-To: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
References: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Message-ID: <1355463184-16283-2-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Mazanov <i.mazanov@gmail.com>

The BeagleBone platform uses TPS65217 PMIC to control voltages
on the board. This patch enables TPS65217 MFD and regulator
drivers in omap2plus_defconfig.

Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a1dc5c0..19b7311 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -132,9 +132,11 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
+CONFIG_MFD_TPS65217=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
+CONFIG_REGULATOR_TPS65217=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5
