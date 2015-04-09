From: nm@ti.com (Nishanth Menon)
Date: Thu, 9 Apr 2015 16:15:19 -0500
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: Enable beaglebone PMIC TPS65217
In-Reply-To: <1428614121-3374-1-git-send-email-nm@ti.com>
References: <1428614121-3374-1-git-send-email-nm@ti.com>
Message-ID: <1428614121-3374-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PMIC for beaglebone similar to commit 7a5c6065669c ("ARM:
OMAP2+: omap2plus_defconfig: Add tps65217 support") - this allows
multi_v7_defconfig to boot up on older beaglebone platforms.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 48dfe885fbb7..11c64858c623 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -346,6 +346,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65090=y
+CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_AB8500=y
@@ -366,6 +367,7 @@ CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TPS65090=y
+CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
-- 
1.7.9.5
