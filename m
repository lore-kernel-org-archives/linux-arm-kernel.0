From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Wed, 11 Nov 2015 12:39:13 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: enable TPS65217 regulator
Message-ID: <1447225753-2788-1-git-send-email-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable TPS65217 regulator to have rootfs in MMC for Beagle Bone's.

Suggested-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fdb52a5..a8b6de1d6d9a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -411,6 +411,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65090=y
+CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_AB8500=y
@@ -441,6 +442,7 @@ CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TPS65090=y
+CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
-- 
2.5.1
