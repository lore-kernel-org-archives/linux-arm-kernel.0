From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 20 Feb 2014 14:38:14 -0300
Subject: [RFC/PATCH] ARM: mvebu: Rename the ARCH_MVEBU menu option
Message-ID: <1392917894-3444-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous name "Marvell SOCs with Device Tree support" is a bit
ambiguous and not too informative for users. Instead, use a more
appropriate name.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Hi everyone,

The previous name is clearly misleading and has been bothering me since
a long time. Here's my proposal, mostly meant to just to kick-start the
discussion.

 arch/arm/mach-mvebu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 5e269d7..b9ba634 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_MVEBU
-	bool "Marvell SOCs with Device Tree support" if ARCH_MULTI_V7
+	bool "Marvell Engineering Business Unit (MVEBU) SoCs" if ARCH_MULTI_V7
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_MMIO
 	select COMMON_CLK
-- 
1.8.1.5
