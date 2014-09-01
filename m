From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  1 Sep 2014 11:03:21 +0900
Subject: [PATCH] clk: shmobile: Add r8a7794 support
In-Reply-To: <cover.1409536884.git.horms+renesas@verge.net.au>
References: <cover.1409536884.git.horms+renesas@verge.net.au>
Message-ID: <8de078f189da45453d2ed2a04288e329cc169731.1409536884.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clk/shmobile/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index e002923..531d4f6 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
 # for emply built-in.o
-- 
2.0.1
