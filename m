From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 20 Feb 2014 15:23:34 -0300
Subject: [RFC/PATCH v2] ARM: mvebu: Rename the ARCH_MVEBU menu option
Message-ID: <1392920614-4372-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous name "Marvell SOCs with Device Tree support" is a bit
ambiguous and not too informative for users. Instead, use a more
appropriate name.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Here's a second attempt, changing also the variant menu,
which I forgot in v1. This (as v1) is mostly inspired in the Berlin
menu config, so to keep some consistency.

Andrew: I didn't add your Acked-by, in case you don't agree with
the new change. Feel free to ack or comment.

 arch/arm/mach-mvebu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 5e269d7..1ba825e 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_MVEBU
-	bool "Marvell SOCs with Device Tree support" if ARCH_MULTI_V7
+	bool "Marvell Engineering Business Unit (MVEBU) SoCs" if ARCH_MULTI_V7
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_MMIO
 	select COMMON_CLK
@@ -19,7 +19,7 @@ config ARCH_MVEBU
 
 if ARCH_MVEBU
 
-menu "Marvell SOC with device tree"
+menu "Marvell EBU SoC variants"
 
 config MACH_ARMADA_370_XP
 	bool
-- 
1.8.1.5
