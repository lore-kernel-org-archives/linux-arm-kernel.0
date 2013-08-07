From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:29:25 +0900
Subject: [GIT PULL 2/2] ARM: shmobile: r8a7740: Add TPU clock entry for DT
 platforms
In-Reply-To: <cover.1375838109.git.horms+renesas@verge.net.au>
References: <cover.1375838109.git.horms+renesas@verge.net.au>
Message-ID: <d687f4d1993fa046171dbb1ca1970a3172ce11b9.1375838109.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index f4265e5..c826bca 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -597,6 +597,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a7740-gether",		&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("renesas-tpu-pwm",	&mstp_clks[MSTP304]),
+	CLKDEV_DEV_ID("e6600000.pwm",		&mstp_clks[MSTP304]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),
-- 
1.8.3.2
