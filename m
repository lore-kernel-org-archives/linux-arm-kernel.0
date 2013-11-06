From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  6 Nov 2013 10:05:47 +0000
Subject: [PATCH 6/7] ARM: ux500: Clean-up legacy extern prototype
In-Reply-To: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
References: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1383732348-18576-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/setup.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index e5682da..7164cfd 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -19,9 +19,6 @@
 void ux500_restart(enum reboot_mode mode, const char *cmd);
 
 void __init ux500_map_io(void);
-extern void __init u8500_map_io(void);
-
-extern struct device * __init u8500_init_devices(void);
 
 extern void __init ux500_init_irq(void);
 
-- 
1.8.1.2
