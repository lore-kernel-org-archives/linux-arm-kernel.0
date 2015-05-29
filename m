From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu, 28 May 2015 19:14:09 -0700
Subject: [PATCH v2 5/6] ARM: brcmstb: Select ARCH_WANT_OPTIONAL_GPIOLIB
In-Reply-To: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1432865650-4062-6-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select ARCH_WANT_OPTIONAL_GPIOLIB from BRCMSTB to allow GPIOLIB and
GPIO_BRCMSTB to be enabled.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
v2: this was split out so that it can go through the ARM SoC tree.

 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8b11f44..0ac9e4b3 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -144,6 +144,7 @@ config ARCH_BRCMSTB
 	select BRCMSTB_GISB_ARB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
 	  chipset.
-- 
1.9.1
