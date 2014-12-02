From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Dec 2014 18:06:52 +0100
Subject: [PATCH] ARM: mvebu: enable CPUFREQ_DT in mvebu_v7_defconfig
Message-ID: <1417540012-5799-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the cpufreq-dt driver in mvebu_v7_defconfig, as it
is used on Armada XP platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Commit based on mvebu/defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 627acce..05edf46 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -26,6 +26,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_MVEBU_V7_CPUIDLE=y
 CONFIG_VFP=y
-- 
2.1.0
