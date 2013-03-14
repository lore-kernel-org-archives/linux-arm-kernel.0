From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 14 Mar 2013 15:19:44 +0800
Subject: [PATCH v4 5/5] ARM: config: append arch hi3xxx into multi defconfig
In-Reply-To: <1363245584-24488-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363245584-24488-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363245584-24488-6-git-send-email-haojian.zhuang@linaro.org>
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
