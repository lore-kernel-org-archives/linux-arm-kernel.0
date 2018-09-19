From: aditya@kobol.io (Aditya Prayoga)
Date: Wed, 19 Sep 2018 11:45:30 +0800
Subject: [PATCH 2/2] ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada 38x
In-Reply-To: <1537328730-9156-1-git-send-email-aditya@kobol.io>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
Message-ID: <1537328730-9156-3-git-send-email-aditya@kobol.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable hidden symbol ARCH_WANT_LIBATA_LEDS so CONFIG_ATA_LEDS can be
used in kernel configuration.

URL: https://lists.openwrt.org/pipermail/openwrt-
devel/2017-March/006582.html

Signed-off-by: Aditya Prayoga <aditya@kobol.io>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 2c20599..51f3256 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -68,6 +68,7 @@ config MACH_ARMADA_38X
 	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_38X
+	select ARCH_WANT_LIBATA_LEDS
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 380/385 SoC with device tree.
-- 
2.7.4
