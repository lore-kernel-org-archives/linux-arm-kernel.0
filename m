From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:25 +0900
Subject: [PATCH 33/43] ARM: mach-shmobile: r8a7740: Add DT names to clock list
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-34-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

This adds temporarily the alternative device names to the clock list
that are used when booting via Device Tree setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 1a9b9a2..1feb9a2 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -593,18 +593,27 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_ceu.1",	&mstp_clks[MSTP128]),
 
 	CLKDEV_DEV_ID("sh-sci.4",		&mstp_clks[MSTP200]),
+	CLKDEV_DEV_ID("e6c80000.sci",		&mstp_clks[MSTP200]),
 	CLKDEV_DEV_ID("sh-sci.3",		&mstp_clks[MSTP201]),
+	CLKDEV_DEV_ID("e6c70000.sci",		&mstp_clks[MSTP201]),
 	CLKDEV_DEV_ID("sh-sci.2",		&mstp_clks[MSTP202]),
+	CLKDEV_DEV_ID("e6c60000.sci",		&mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.1",		&mstp_clks[MSTP203]),
+	CLKDEV_DEV_ID("e6c50000.sci",		&mstp_clks[MSTP203]),
 	CLKDEV_DEV_ID("sh-sci.0",		&mstp_clks[MSTP204]),
+	CLKDEV_DEV_ID("e6c40000.sci",		&mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.8",		&mstp_clks[MSTP206]),
+	CLKDEV_DEV_ID("e6c30000.sci",		&mstp_clks[MSTP206]),
 	CLKDEV_DEV_ID("sh-sci.5",		&mstp_clks[MSTP207]),
+	CLKDEV_DEV_ID("e6cb0000.sci",		&mstp_clks[MSTP207]),
 	CLKDEV_DEV_ID("sh-dma-engine.3",	&mstp_clks[MSTP214]),
 	CLKDEV_DEV_ID("sh-dma-engine.2",	&mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-dma-engine.1",	&mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("sh-dma-engine.0",	&mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("sh-sci.7",		&mstp_clks[MSTP222]),
+	CLKDEV_DEV_ID("e6cd0000.sci",		&mstp_clks[MSTP222]),
 	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
+	CLKDEV_DEV_ID("e6cc0000.sci",		&mstp_clks[MSTP230]),
 
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
-- 
1.7.10.4
