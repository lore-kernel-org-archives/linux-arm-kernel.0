From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 26 Jun 2014 12:05:46 +0800
Subject: [PATCH v4 7/8] ARM: config: add ARCH_HIX5HD2 in hi3xxx_defconfig
In-Reply-To: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
References: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1403755547-623-8-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since both ARCH_HI3xxx and ARCH_HIX5HD2 are based on Cortex A9 & they're
using similiar kernel features, make them share the same default config.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/hi3xxx_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/hi3xxx_defconfig b/arch/arm/configs/hi3xxx_defconfig
index f186bdf..9630687 100644
--- a/arch/arm/configs/hi3xxx_defconfig
+++ b/arch/arm/configs/hi3xxx_defconfig
@@ -3,7 +3,9 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
+CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
+CONFIG_ARCH_HIX5HD2=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.9.1
