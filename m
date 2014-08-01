From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 1 Aug 2014 11:58:54 +0800
Subject: [PATCH 1/3] ARM: remove unnecessary include arm_timer.h and timer-sp.h
In-Reply-To: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1406865536-23984-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mach-nspire/nspire.c     | 2 --
 arch/arm/mach-vexpress/ct-ca9x4.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 3d24ebf..ba3607e 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -22,8 +22,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
-#include <asm/hardware/timer-sp.h>
-
 #include "mmio.h"
 #include "clcd.h"
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 86150d7..18a6907 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -12,15 +12,12 @@
 #include <linux/vexpress.h>
 #include <linux/irqchip/arm-gic.h>
 
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 
 #include <mach/ct-ca9x4.h>
 
-#include <asm/hardware/timer-sp.h>
-
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-- 
1.7.12.4
