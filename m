From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 16:47:19 -0700
Subject: [PATCH 2/5] clk: tegra: remove some redundant defines from Tegra114
In-Reply-To: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
References: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384991242-13596-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

These #defines aren't used. Delete them.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This probably should be squashed into commit 32721a734a3d "clk: tegra:
move PMC, fixed clocks to common files".
---
 drivers/clk/tegra/clk-tegra114.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 9036a22ee5aa..70bfefebcca5 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -107,13 +107,6 @@
 #define PLLC_OUT 0x84
 #define PLLM_OUT 0x94
 
-#define PMC_CLK_OUT_CNTRL 0x1a8
-#define PMC_DPD_PADS_ORIDE 0x1c
-#define PMC_DPD_PADS_ORIDE_BLINK_ENB 20
-#define PMC_CTRL 0
-#define PMC_CTRL_BLINK_ENB 7
-#define PMC_BLINK_TIMER 0x40
-
 #define OSC_CTRL			0x50
 #define OSC_CTRL_OSC_FREQ_SHIFT		28
 #define OSC_CTRL_PLL_REF_DIV_SHIFT	26
-- 
1.8.1.5
