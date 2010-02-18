From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Feb 2010 17:32:12 -0800
Subject: [PATCH 09/23] omap3: Fix typo on IGEP v2 board
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Message-ID: <20100218013212.32075.42879.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Fix typo on IGEP v2 board

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f90b225..2e81a6e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -131,7 +131,7 @@ config MACH_CM_T35
 	select OMAP_MUX
 
 config MACH_IGEP0020
-	bool "IGEP0020"
+	bool "IGEP v2 board"
 	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
