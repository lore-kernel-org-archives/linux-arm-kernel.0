From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:41 -0700
Subject: [PATCH 29/29] ARM: OMAP2+: Make omap4-keypad.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210641.28074.51565.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c            |    2 +-
 arch/arm/mach-omap2/devices.c                  |    2 +-
 arch/arm/mach-omap2/omap4-keypad.h             |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/{plat-omap/include/plat/omap4-keypad.h => mach-omap2/omap4-keypad.h} (100%)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index dd4c88d..9066b7b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -36,7 +36,7 @@
 #include "common.h"
 #include <plat/usb.h>
 #include <plat/mmc.h>
-#include <plat/omap4-keypad.h>
+#include "omap4-keypad.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-nokia-dsi.h>
 #include <video/omap-panel-picodlp.h>
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index f6cbcdc..24228c9 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -27,7 +27,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
-#include <plat/omap4-keypad.h>
+#include "omap4-keypad.h"
 
 #include "soc.h"
 #include "common.h"
diff --git a/arch/arm/plat-omap/include/plat/omap4-keypad.h b/arch/arm/mach-omap2/omap4-keypad.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/omap4-keypad.h
rename to arch/arm/mach-omap2/omap4-keypad.h
