From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 16:47:20 -0700
Subject: [PATCH 3/5] clk: tegra: remove some redundant defines from Tegra30
In-Reply-To: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
References: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384991242-13596-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

These #defines aren't used. Delete them.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This probably should be squashed into commit ba2e2e8f2c55 "clk: tegra:
move tegra30 to common infra".
---
 drivers/clk/tegra/clk-tegra30.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 51c093c96657..92c46f1fb5d1 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -118,13 +118,6 @@
 
 #define AUDIO_SYNC_DOUBLER 0x49c
 
-#define PMC_CTRL 0
-#define PMC_CTRL_BLINK_ENB 7
-
-#define PMC_DPD_PADS_ORIDE 0x1c
-#define PMC_DPD_PADS_ORIDE_BLINK_ENB 20
-#define PMC_BLINK_TIMER 0x40
-
 #define UTMIP_PLL_CFG2 0x488
 #define UTMIP_PLL_CFG2_STABLE_COUNT(x) (((x) & 0xffff) << 6)
 #define UTMIP_PLL_CFG2_ACTIVE_DLY_COUNT(x) (((x) & 0x3f) << 18)
-- 
1.8.1.5
