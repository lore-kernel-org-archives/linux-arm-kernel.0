From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 12 Feb 2014 13:09:37 +0900
Subject: [PATCH] ARM: shmobile: Remove legacy r8a7790 DT clocks
Message-ID: <20140212040937.9955.38466.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The DT device case is handled by CCF these days, so get
rid of DT devices from the legacy clocks for r8a7790.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7790.c |   11 -----------
 1 file changed, 11 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7790.c
+++ work/arch/arm/mach-shmobile/clock-r8a7790.c	2014-02-10 16:04:29.000000000 +0900
@@ -328,34 +328,23 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
-	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.0", &mstp_clks[MSTP931]),
-	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.1", &mstp_clks[MSTP930]),
-	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.2", &mstp_clks[MSTP929]),
-	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.3", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("r8a7790-vin.0", &mstp_clks[MSTP811]),
 	CLKDEV_DEV_ID("r8a7790-vin.1", &mstp_clks[MSTP810]),
 	CLKDEV_DEV_ID("r8a7790-vin.2", &mstp_clks[MSTP809]),
 	CLKDEV_DEV_ID("r8a7790-vin.3", &mstp_clks[MSTP808]),
-	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP502]),
 	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP501]),
-	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
-	CLKDEV_DEV_ID("ee100000.sd", &mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]),
-	CLKDEV_DEV_ID("ee120000.sd", &mstp_clks[MSTP313]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]),
-	CLKDEV_DEV_ID("ee140000.sd", &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
-	CLKDEV_DEV_ID("ee160000.sd", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP311]),
-	CLKDEV_DEV_ID("ee220000.mmc", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
