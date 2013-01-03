From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:23 -0600
Subject: [PATCH v4 14/19] ARM: remove unneeded vic.h includes
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-15-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Numerous includes of asm/hardware/vic.h aren't needed, so remove them.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-samsung-soc at vger.kernel.org
Cc: patches at opensource.wolfsonmicro.com
---
 arch/arm/mach-ep93xx/adssphere.c              |    1 -
 arch/arm/mach-ep93xx/edb93xx.c                |    1 -
 arch/arm/mach-ep93xx/gesbc9312.c              |    1 -
 arch/arm/mach-ep93xx/micro9.c                 |    1 -
 arch/arm/mach-ep93xx/simone.c                 |    1 -
 arch/arm/mach-ep93xx/snappercl15.c            |    1 -
 arch/arm/mach-ep93xx/ts72xx.c                 |    1 -
 arch/arm/mach-ep93xx/vision_ep9307.c          |    1 -
 arch/arm/mach-netx/nxdb500.c                  |    1 -
 arch/arm/mach-netx/nxdkn.c                    |    1 -
 arch/arm/mach-netx/nxeb500hmi.c               |    1 -
 arch/arm/mach-nomadik/board-nhk8815.c         |    1 -
 arch/arm/mach-s3c64xx/mach-anw6410.c          |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c         |    1 -
 arch/arm/mach-s3c64xx/mach-hmt.c              |    1 -
 arch/arm/mach-s3c64xx/mach-mini6410.c         |    1 -
 arch/arm/mach-s3c64xx/mach-ncp.c              |    1 -
 arch/arm/mach-s3c64xx/mach-real6410.c         |    1 -
 arch/arm/mach-s3c64xx/mach-smartq5.c          |    1 -
 arch/arm/mach-s3c64xx/mach-smartq7.c          |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c         |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c         |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6440.c         |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6450.c         |    1 -
 arch/arm/mach-s5pc100/mach-smdkc100.c         |    1 -
 arch/arm/mach-s5pv210/include/mach/regs-irq.h |    1 -
 arch/arm/mach-s5pv210/mach-aquila.c           |    1 -
 arch/arm/mach-s5pv210/mach-goni.c             |    1 -
 arch/arm/mach-s5pv210/mach-smdkc110.c         |    1 -
 arch/arm/mach-s5pv210/mach-smdkv210.c         |    1 -
 arch/arm/mach-s5pv210/mach-torbreck.c         |    1 -
 arch/arm/mach-sunxi/sunxi.c                   |    1 -
 arch/arm/mach-versatile/versatile_ab.c        |    1 -
 arch/arm/mach-versatile/versatile_dt.c        |    1 -
 arch/arm/mach-versatile/versatile_pb.c        |    1 -
 35 files changed, 35 deletions(-)

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 03f793e..19332bf 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -17,7 +17,6 @@
 
 #include <mach/hardware.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 4423a1e..5abf2cb 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -39,7 +39,6 @@
 #include <linux/platform_data/spi-ep93xx.h>
 #include <mach/gpio-ep93xx.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 6df752f..2a7375b 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -17,7 +17,6 @@
 
 #include <mach/hardware.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 6a66cda..723c0d3 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -18,7 +18,6 @@
 
 #include <mach/hardware.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index a5dba8f..651a7db 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -25,7 +25,6 @@
 #include <linux/platform_data/video-ep93xx.h>
 #include <mach/gpio-ep93xx.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 6be24c0..b4389d3 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -31,7 +31,6 @@
 #include <linux/platform_data/video-ep93xx.h>
 #include <mach/gpio-ep93xx.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 66703f7..1eeee09 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -22,7 +22,6 @@
 
 #include <mach/hardware.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 88303a2..723d048 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -34,7 +34,6 @@
 #include <linux/platform_data/spi-ep93xx.h>
 #include <mach/gpio-ep93xx.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-netx/nxdb500.c b/arch/arm/mach-netx/nxdb500.c
index fe40c52..04d5e5e 100644
--- a/arch/arm/mach-netx/nxdb500.c
+++ b/arch/arm/mach-netx/nxdb500.c
@@ -28,7 +28,6 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/vic.h>
 #include <mach/netx-regs.h>
 #include <linux/platform_data/eth-netx.h>
 
diff --git a/arch/arm/mach-netx/nxdkn.c b/arch/arm/mach-netx/nxdkn.c
index e09d0d4..cf15bdd 100644
--- a/arch/arm/mach-netx/nxdkn.c
+++ b/arch/arm/mach-netx/nxdkn.c
@@ -28,7 +28,6 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/vic.h>
 #include <mach/netx-regs.h>
 #include <linux/platform_data/eth-netx.h>
 
diff --git a/arch/arm/mach-netx/nxeb500hmi.c b/arch/arm/mach-netx/nxeb500hmi.c
index 169172b..069bd26 100644
--- a/arch/arm/mach-netx/nxeb500hmi.c
+++ b/arch/arm/mach-netx/nxeb500hmi.c
@@ -28,7 +28,6 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/vic.h>
 #include <mach/netx-regs.h>
 #include <linux/platform_data/eth-netx.h>
 
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 9c15879..edb3f8a 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -28,7 +28,6 @@
 #include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/platform_data/clocksource-nomadik-mtu.h>
 #include <linux/platform_data/mtd-nomadik-nand.h>
-#include <asm/hardware/vic.h>
 #include <asm/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 94c9e8a..fa570c2 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -31,7 +31,6 @@
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 29bfec2..9b6f20c 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -42,7 +42,6 @@
 
 #include <sound/wm1250-ev1.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 052c459..2c81bf1 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -30,7 +30,6 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index b5635fe..3f1e010 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -24,7 +24,6 @@
 #include <linux/serial_core.h>
 #include <linux/types.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 08a445c..73caf9f 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -26,7 +26,6 @@
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 5980c18..4f8129d 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -25,7 +25,6 @@
 #include <linux/serial_core.h>
 #include <linux/types.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 28f3303..323399b 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -17,7 +17,6 @@
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 2d8a5d5..9077b85 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -17,7 +17,6 @@
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 9de7c26..7df76e4 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -22,7 +22,6 @@
 
 #include <asm/mach-types.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 65fea58..ad5142a 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -45,7 +45,6 @@
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 7b752ac..e241929 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -29,7 +29,6 @@
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/irq.h>
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 97585f3..9992731 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -29,7 +29,6 @@
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/irq.h>
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 99686de..c3f3095 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -25,7 +25,6 @@
 #include <linux/input.h>
 #include <linux/pwm_backlight.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-irq.h b/arch/arm/mach-s5pv210/include/mach/regs-irq.h
index 5c3b104..d8bc1e6 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-irq.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-irq.h
@@ -13,7 +13,6 @@
 #ifndef __ASM_ARCH_REGS_IRQ_H
 #define __ASM_ARCH_REGS_IRQ_H __FILE__
 
-#include <asm/hardware/vic.h>
 #include <mach/map.h>
 
 #endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 1cba073..45eb0a8 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -22,7 +22,6 @@
 #include <linux/input.h>
 #include <linux/gpio.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 8f26d53..9f7f160 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -29,7 +29,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 7fa0221..2f152f9 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -15,7 +15,6 @@
 #include <linux/i2c.h>
 #include <linux/device.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index ebf31ee..721967b 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -21,7 +21,6 @@
 #include <linux/pwm_backlight.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 8936018..0ed270f 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/serial_core.h>
 
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 9be910f..b1b5131 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -21,7 +21,6 @@
 
 #include <linux/irqchip/sunxi.h>
 
-#include <asm/hardware/vic.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-versatile/versatile_ab.c b/arch/arm/mach-versatile/versatile_ab.c
index 886d976..ddeec67 100644
--- a/arch/arm/mach-versatile/versatile_ab.c
+++ b/arch/arm/mach-versatile/versatile_ab.c
@@ -26,7 +26,6 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 17782cd..f48f2e4 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 4119320..e52eb23 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -27,7 +27,6 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/vic.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-- 
1.7.10.4
