From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  8 Apr 2014 16:00:50 +0800
Subject: [PATCH v2 10/12] ARM: config: select ARCH_HISI in hi3xxx_defconfig
In-Reply-To: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1396944052-9887-11-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARCH_HISI is added as common configuration of both ARCH_HI3xxx and
ARCH_HIP04, update it into hi3xxx_defconfig.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/hi3xxx_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/hi3xxx_defconfig b/arch/arm/configs/hi3xxx_defconfig
index f186bdf..f8c78ac 100644
--- a/arch/arm/configs/hi3xxx_defconfig
+++ b/arch/arm/configs/hi3xxx_defconfig
@@ -3,6 +3,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
+CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
-- 
1.8.3.2
