From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 May 2014 12:17:35 +0200
Subject: [PATCH v6 10/17] ARM: mvebu: add USB3 support for Armada 38x
In-Reply-To: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1400149062-32661-11-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the selection of the config symbol needed to build the
USB3 support for Armada 38x into mvebu_v7_defconfig.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 3f73eecbcfb0..7960f218702b 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -54,6 +54,7 @@ config MACH_ARMADA_38X
 	select CPU_V7
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_38X
+	select USB_ARCH_HAS_XHCI
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 380/385 SoC with device tree.
-- 
1.8.1.2
