From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 16:47:22 -0700
Subject: [PATCH 5/5] clk: tegra: remove some redundant defines from Tegra124
In-Reply-To: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
References: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384991242-13596-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

These #defines aren't used. Delete them.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This probably should be squashed into commit 8a0fc8917eef "clk: tegra124:
Add support for Tegra124 clocks".
---
 drivers/clk/tegra/clk-tegra124.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 266e80b51d38..623fbf35ee08 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -84,8 +84,6 @@
 
 #define PLLXC_SW_MAX_P 6
 
-#define PMC_BLINK_TIMER 0x40
-
 #define PMC_PLLM_WB0_OVERRIDE 0x1dc
 #define PMC_PLLM_WB0_OVERRIDE_2 0x2b0
 
-- 
1.8.1.5
