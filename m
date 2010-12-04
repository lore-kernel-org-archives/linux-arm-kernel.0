From: tony@atomide.com (Tony Lindgren)
Date: Sat, 04 Dec 2010 13:29:56 -0800
Subject: [PATCH 5/5] omap: Don't select mux by default for each board
In-Reply-To: <20101204212904.25978.22090.stgit@baageli.muru.com>
References: <20101204212904.25978.22090.stgit@baageli.muru.com>
Message-ID: <20101204212956.25978.81871.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should be only selected in CONFIG_ARCH_OMAP2PLUS_TYPICAL
to make it easy to disable.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index fc3a181..144e7bb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -134,7 +134,6 @@ config MACH_DEVKIT8000
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CUS
-	select OMAP_MUX
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
@@ -250,14 +249,12 @@ config MACH_CM_T35
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CUS
-	select OMAP_MUX
 
 config MACH_CM_T3517
 	bool "CompuLab CM-T3517 module"
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
-	select OMAP_MUX
 
 config MACH_IGEP0020
 	bool "IGEP v2 board"
@@ -276,7 +273,6 @@ config MACH_SBC3530
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CUS
-	select OMAP_MUX
 
 config MACH_OMAP_3630SDP
 	bool "OMAP3630 SDP board"
