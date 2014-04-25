From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Apr 2014 16:07:13 +0200
Subject: [PATCH v2 15/18] ARM: mvebu: Add USB3 support for Armada 375
In-Reply-To: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1398434836-18908-16-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the selection of the config symbol to build the USB3
support for Armada 375.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 7960f218702b..95afc7677ee1 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -41,6 +41,7 @@ config MACH_ARMADA_375
 	select CPU_V7
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_375
+	select USB_ARCH_HAS_XHCI
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 375 SoC with device tree.
-- 
1.8.1.2
