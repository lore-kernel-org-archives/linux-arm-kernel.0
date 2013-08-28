From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 28 Aug 2013 21:10:51 +0800
Subject: [PATCH v9 4/7] ARM: config: enable hi3xxx in multi_v7_defconfig
In-Reply-To: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
References: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1377695454-29109-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARCH_HI3xxx in multi_v7_defconfig.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fe0bdc3..c7b5247 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -8,6 +8,7 @@ CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_BCM=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_HIGHBANK=y
+CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX51_DT=y
-- 
1.8.1.2
