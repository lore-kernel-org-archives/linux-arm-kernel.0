From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 21:54:21 +0800
Subject: [PATCH] ARM: imx: remove Makefile.boot
Message-ID: <1364910861-19178-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have converted IMX to multiplatform build, Makefile.boot is not
used anyway.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile.boot |   35 -----------------------------------
 1 file changed, 35 deletions(-)
 delete mode 100644 arch/arm/mach-imx/Makefile.boot

diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
deleted file mode 100644
index 41ba1bb..0000000
--- a/arch/arm/mach-imx/Makefile.boot
+++ /dev/null
@@ -1,35 +0,0 @@
-zreladdr-$(CONFIG_SOC_IMX1)	+= 0x08008000
-params_phys-$(CONFIG_SOC_IMX1)	:= 0x08000100
-initrd_phys-$(CONFIG_SOC_IMX1)	:= 0x08800000
-
-zreladdr-$(CONFIG_SOC_IMX21)	+= 0xC0008000
-params_phys-$(CONFIG_SOC_IMX21)	:= 0xC0000100
-initrd_phys-$(CONFIG_SOC_IMX21)	:= 0xC0800000
-
-zreladdr-$(CONFIG_SOC_IMX25)	+= 0x80008000
-params_phys-$(CONFIG_SOC_IMX25)	:= 0x80000100
-initrd_phys-$(CONFIG_SOC_IMX25)	:= 0x80800000
-
-zreladdr-$(CONFIG_SOC_IMX27)	+= 0xA0008000
-params_phys-$(CONFIG_SOC_IMX27)	:= 0xA0000100
-initrd_phys-$(CONFIG_SOC_IMX27)	:= 0xA0800000
-
-zreladdr-$(CONFIG_SOC_IMX31)	+= 0x80008000
-params_phys-$(CONFIG_SOC_IMX31)	:= 0x80000100
-initrd_phys-$(CONFIG_SOC_IMX31)	:= 0x80800000
-
-zreladdr-$(CONFIG_SOC_IMX35)	+= 0x80008000
-params_phys-$(CONFIG_SOC_IMX35)	:= 0x80000100
-initrd_phys-$(CONFIG_SOC_IMX35)	:= 0x80800000
-
-zreladdr-$(CONFIG_SOC_IMX51)	+= 0x90008000
-params_phys-$(CONFIG_SOC_IMX51)	:= 0x90000100
-initrd_phys-$(CONFIG_SOC_IMX51)	:= 0x90800000
-
-zreladdr-$(CONFIG_SOC_IMX53)	+= 0x70008000
-params_phys-$(CONFIG_SOC_IMX53)	:= 0x70000100
-initrd_phys-$(CONFIG_SOC_IMX53)	:= 0x70800000
-
-zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
-params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
-initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
-- 
1.7.9.5
