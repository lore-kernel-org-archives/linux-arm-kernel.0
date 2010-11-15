From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Mon, 15 Nov 2010 06:31:09 -0800 (PST)
Subject: [PATCH] mx35_3ds: Add watchdog support
Message-ID: <181400.63708.qm@web51004.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx35_3ds: Add watchdog support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/mach-mx35_3ds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 6b51fec..30e73bd 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -79,6 +79,7 @@ static const struct mxc_nand_platform_data mx35pdk_nand_board_info __initconst =
 
 static struct platform_device *devices[] __initdata = {
 	&mx35pdk_flash,
+	&imx_wdt_device0,
 };
 
 static iomux_v3_cfg_t mx35pdk_pads[] = {
-- 
1.6.0.4


      
