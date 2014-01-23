From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 23 Jan 2014 14:57:39 +0530
Subject: [PATCH] ARM: davinci: defconfig: drop CONFIG_REGULATOR_DUMMY
Message-ID: <1390469259-11483-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

This patch drops CONFIG_REGULATOR_DUMMY as this obsolete.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/configs/da8xx_omapl_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index 1571bea..c78de86 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -89,7 +89,6 @@ CONFIG_PINCTRL_SINGLE=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_REGULATOR=y
-CONFIG_REGULATOR_DUMMY=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_FB=y
 CONFIG_FB_DA8XX=y
-- 
1.7.9.5
