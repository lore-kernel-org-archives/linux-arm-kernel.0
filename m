From: gbean@codeaurora.org (Gregory Bean)
Date: Tue, 16 Nov 2010 13:35:05 -0800
Subject: [PATCH] msm: 8x60: Add TLMM to the iomap.
Message-ID: <1289943305-10949-1-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the TLMM block to the iomap for MSM8x60 to make gpio
control registers available.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 arch/arm/mach-msm/io.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index d36b610..e27d041 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -107,6 +107,7 @@ static struct map_desc msm8x60_io_desc[] __initdata = {
 	MSM_DEVICE(TMR),
 	MSM_DEVICE(ACC),
 	MSM_DEVICE(GCC),
+	MSM_DEVICE(TLMM),
 };
 
 void __init msm_map_msm8x60_io(void)
-- 
1.7.0.4

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
