From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat,  6 Feb 2016 02:43:17 +0900
Subject: [PATCH] ARM: netx: remove redundant "depends on ARCH_NETX"
Message-ID: <1454694197-15200-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These options already reside inside the ARCH_NETX-dependent menu.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-netx/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-netx/Kconfig b/arch/arm/mach-netx/Kconfig
index 3d90ef1..2da8e5d 100644
--- a/arch/arm/mach-netx/Kconfig
+++ b/arch/arm/mach-netx/Kconfig
@@ -3,20 +3,17 @@ menu "NetX Implementations"
 
 config MACH_NXDKN
 	bool "Enable Hilscher nxdkn Eval Board support"
-	depends on ARCH_NETX
 	help
 	  Board support for the Hilscher NetX Eval Board
 
 config MACH_NXDB500
 	bool "Enable Hilscher nxdb500 Eval Board support"
-	depends on ARCH_NETX
 	select ARM_AMBA
 	help
 	  Board support for the Hilscher nxdb500 Eval Board
 
 config MACH_NXEB500HMI
 	bool "Enable Hilscher nxeb500hmi Eval Board support"
-	depends on ARCH_NETX
 	select ARM_AMBA
 	help
 	  Board support for the Hilscher nxeb500hmi Eval Board
-- 
1.9.1
