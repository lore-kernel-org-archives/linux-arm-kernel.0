From: nm@ti.com (Nishanth Menon)
Date: Thu, 9 Apr 2015 16:15:20 -0500
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Enable AM437x PMIC TPS65218
In-Reply-To: <1428614121-3374-1-git-send-email-nm@ti.com>
References: <1428614121-3374-1-git-send-email-nm@ti.com>
Message-ID: <1428614121-3374-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PMIC for AM437x platforms such as AM437x-sk similar to commit
a186cf10da84 ("ARM: omap2plus_defconfig: enable TPS65218 configs").
This allows multi_v7_defconfig to boot up on AM437x-sk platform.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 11c64858c623..f48dfa7787dc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -347,6 +347,7 @@ CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65090=y
 CONFIG_MFD_TPS65217=y
+CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_AB8500=y
@@ -368,6 +369,7 @@ CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TPS65090=y
 CONFIG_REGULATOR_TPS65217=y
+CONFIG_REGULATOR_TPS65218=y
 CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
-- 
1.7.9.5
