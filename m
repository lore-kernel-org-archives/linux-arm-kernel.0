From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 13:05:42 +0800
Subject: [PATCH v3 11/11] ARM: config: append arch hi3xxx into multi defconfig
In-Reply-To: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363151142-32162-12-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append ARCH_HI3xxx (Hisilicon SoC) into multi_v7_defconfig.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e31d442..1891611 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_HIGHBANK=y
+CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_ARCH_SUNXI=y
 # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
-- 
1.7.10.4
