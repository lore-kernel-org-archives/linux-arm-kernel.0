From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  4 Mar 2013 15:08:26 -0800
Subject: [PATCH/RESEND 2/4] mmc: msm_sdcc: Remove unnecessary include
In-Reply-To: <1362438508-26614-1-git-send-email-sboyd@codeaurora.org>
References: <1362438508-26614-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1362438508-26614-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has no reason to include msm_iomap.h. Remove it so
that we can remove msm_iomap.h from include/mach in the near future.

Acked-by: Chris Ball <cjb@laptop.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 7c0af0e..0ee4a57 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -43,7 +43,6 @@
 #include <asm/sizes.h>
 
 #include <linux/platform_data/mmc-msm_sdcc.h>
-#include <mach/msm_iomap.h>
 #include <mach/dma.h>
 #include <mach/clk.h>
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
