From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 13 May 2014 17:44:40 +0800
Subject: [PATCH v2 5/6] ARM: config: add ARCH_HIX5HD2 in hi3xxx_defconfig
In-Reply-To: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399974281-9737-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since both ARCH_HI3xxx and ARCH_HIX5HD2 are based on Cortex A9 & they're
using similiar kernel features, make them share the same default config.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/hi3xxx_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/hi3xxx_defconfig b/arch/arm/configs/hi3xxx_defconfig
index 553e1b6..132d8c8 100644
--- a/arch/arm/configs/hi3xxx_defconfig
+++ b/arch/arm/configs/hi3xxx_defconfig
@@ -5,6 +5,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
+CONFIG_ARCH_HIX5HD2=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.9.1
