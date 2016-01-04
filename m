From: kwizart@gmail.com (Nicolas Chauvet)
Date: Mon,  4 Jan 2016 22:41:50 +0100
Subject: [PATCH] Remove CONFIG_CRYPTO_DEV_TEGRA_AES from multi_v7_defconfig
Message-ID: <1451943710-6253-1-git-send-email-kwizart@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The related driver was removed by commit 645af2e4 on Feb 2014
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fd..ae7e769 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -727,7 +727,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
-CONFIG_CRYPTO_DEV_TEGRA_AES=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_CRYPTO_DEV_SUN4I_SS=m
-- 
2.4.3
