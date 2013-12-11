From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 11 Dec 2013 15:54:57 +0800
Subject: [PATCH v12 08/08] ARM: hi3xxx: select GPIO in Kconfig
In-Reply-To: <1386748497-11290-1-git-send-email-haojian.zhuang@gmail.com>
References: <1386748497-11290-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1386748497-11290-9-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select GPIO in hi3xxx Kconfig.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-hi3xxx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
index 4007ecf..018ad67 100644
--- a/arch/arm/mach-hi3xxx/Kconfig
+++ b/arch/arm/mach-hi3xxx/Kconfig
@@ -3,6 +3,7 @@ config ARCH_HI3xxx
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CACHE_L2X0
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
-- 
1.8.3.2
