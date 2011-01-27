From: davidb@codeaurora.org (David Brown)
Date: Wed, 26 Jan 2011 16:14:23 -0800
Subject: [PATCH 1/2] msm: Remove broken register definition from trout
Message-ID: <1296087264-9659-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missed a register change with the clock cleanup on the MSM7x01 targets.

Change-Id: Ic42234b67f6c15760d74f9efca2932cc739931e4
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/io.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index d8d9be5..cec6ed1 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -42,7 +42,6 @@
 static struct map_desc msm_io_desc[] __initdata = {
 	MSM_DEVICE(VIC),
 	MSM_CHIP_DEVICE(CSR, MSM7X00),
-	MSM_DEVICE(GPT),
 	MSM_DEVICE(DMOV),
 	MSM_DEVICE(GPIO1),
 	MSM_DEVICE(GPIO2),
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
