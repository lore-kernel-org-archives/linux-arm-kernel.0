From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 13 May 2014 17:03:33 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7740: Correct name of DT Ethernet clock
In-Reply-To: <cover.1399967342.git.horms+renesas@verge.net.au>
References: <cover.1399967342.git.horms+renesas@verge.net.au>
Message-ID: <93131c36d49e932151a5f482f50ea40f3f0c987f.1399967342.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The preferred node name in DT for an Ethernet device is "ethernet".
"sh-eth" was used in preliminary and incomplete bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index dd989f9..433ec67 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -596,7 +596,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("e6bd0000.mmc",		&mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("r8a7740-gether",		&mstp_clks[MSTP309]),
-	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
+	CLKDEV_DEV_ID("e9a00000.ethernet",	&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("renesas-tpu-pwm",	&mstp_clks[MSTP304]),
 	CLKDEV_DEV_ID("e6600000.pwm",		&mstp_clks[MSTP304]),
 
-- 
1.8.5.2
