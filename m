From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 28 Sep 2016 13:35:28 +0300
Subject: [PATCH 2/4] ARM: davinci: devices: Remove DMA resources for MMC
In-Reply-To: <20160928103530.15291-1-peter.ujfalusi@ti.com>
References: <20160928103530.15291-1-peter.ujfalusi@ti.com>
Message-ID: <20160928103530.15291-3-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is converted to not use the DMA resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 67d26c5bda0b..3ae70f2909b0 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -36,9 +36,6 @@
 #define DM365_MMCSD0_BASE	     0x01D11000
 #define DM365_MMCSD1_BASE	     0x01D00000
 
-#define DAVINCI_DMA_MMCRXEVT	26
-#define DAVINCI_DMA_MMCTXEVT	27
-
 void __iomem  *davinci_sysmod_base;
 
 void davinci_map_sysmod(void)
-- 
2.10.0
