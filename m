From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sat, 24 Aug 2013 17:30:00 +0800
Subject: [PATCH v8 5/8] ARM: config: enable hi3xxx in multi_v7_defconfig
In-Reply-To: <1377336603-10303-1-git-send-email-haojian.zhuang@linaro.org>
References: <1377336603-10303-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1377336603-10303-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARCH_HI3xxx in multi_v7_defconfig.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e572c6..6855397 100644
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
