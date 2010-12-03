From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu,  2 Dec 2010 16:39:44 -0800
Subject: [PATCH 3/4] msm: trout: change name of pmdh_clk to mddi_clk
In-Reply-To: <1291336785-29108-1-git-send-email-dwalker@codeaurora.org>
References: <1291336785-29108-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1291336785-29108-3-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock is used in the framebuffer driver as mddi_clk.
This just changes the name to match that. This also
mirrors a change in Google tree.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mach-msm/devices-msm7x00.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index 3bf8cb5..b00a94b 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -364,7 +364,7 @@ struct clk msm_clocks_7x01a[] = {
 	CLK_PCOM("mdp_clk",	MDP_CLK,	NULL, OFF),
 	CLK_PCOM("pbus_clk",	PBUS_CLK,	NULL, 0),
 	CLK_PCOM("pcm_clk",	PCM_CLK,	NULL, 0),
-	CLK_PCOM("pmdh_clk",	PMDH_CLK,	NULL, OFF | CLK_MINMAX),
+	CLK_PCOM("mddi_clk",	PMDH_CLK,	NULL, OFF | CLK_MINMAX),
 	CLK_PCOM("sdac_clk",	SDAC_CLK,	NULL, OFF),
 	CLK_PCOM("sdc_clk",	SDC1_CLK,	&msm_device_sdc1.dev, OFF),
 	CLK_PCOM("sdc_pclk",	SDC1_P_CLK,	&msm_device_sdc1.dev, OFF),
-- 
1.7.1

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
