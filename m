From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:47 +0900
Subject: [PATCH 06/12] ARM: shmobile: r8a7740: Add I2C DT clock names
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

Add clock association for i2c0 and i2c1 for the new DT names.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index a2a612f..b12c476 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -551,6 +551,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_tmu.4",		&mstp_clks[MSTP111]),
 	CLKDEV_DEV_ID("sh_tmu.5",		&mstp_clks[MSTP111]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.0",	&mstp_clks[MSTP116]),
+	CLKDEV_DEV_ID("fff20000.i2c",		&mstp_clks[MSTP116]),
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1",	&mstp_clks[MSTP117]),
 	CLKDEV_DEV_ID("sh_tmu.0",		&mstp_clks[MSTP125]),
 	CLKDEV_DEV_ID("sh_tmu.1",		&mstp_clks[MSTP125]),
@@ -585,6 +586,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6138010.timer",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
+	CLKDEV_DEV_ID("e6c20000.i2c",		&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0",	&mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("e6850000.sdhi",          &mstp_clks[MSTP314]),
-- 
1.7.10.4
