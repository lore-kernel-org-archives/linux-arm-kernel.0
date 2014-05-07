From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed,  7 May 2014 22:44:45 +0800
Subject: [PATCH v5 11/14] ARM: config: select ARCH_HISI in hi3xxx_defconfig
In-Reply-To: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399473888-12947-12-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARCH_HISI is added as common configuration of both ARCH_HI3xxx and
ARCH_HIP04, update it into hi3xxx_defconfig.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/hi3xxx_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/hi3xxx_defconfig b/arch/arm/configs/hi3xxx_defconfig
index f186bdf..553e1b6 100644
--- a/arch/arm/configs/hi3xxx_defconfig
+++ b/arch/arm/configs/hi3xxx_defconfig
@@ -3,10 +3,12 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
+CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_NET=y
 CONFIG_UNIX=y
-- 
1.9.1
