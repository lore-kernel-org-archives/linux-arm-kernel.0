From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 11 Dec 2013 15:54:52 +0800
Subject: [PATCH v12 03/08] ARM: config: enable hi3xxx in multi_v7_defconfig
In-Reply-To: <1386748497-11290-1-git-send-email-haojian.zhuang@gmail.com>
References: <1386748497-11290-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1386748497-11290-4-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@linaro.org>

Enable ARCH_HI3xxx in multi_v7_defconfig.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4a5903e..7910d22 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -9,6 +9,7 @@ CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_MOBILE=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_HIGHBANK=y
+CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX51_DT=y
-- 
1.8.3.2
