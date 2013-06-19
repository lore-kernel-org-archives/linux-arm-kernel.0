From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Jun 2013 17:04:31 -0700
Subject: [PATCH 01/11] ARM: msm: Remove unused and unmapped MSM_TLMM_BASE for
 8x60
In-Reply-To: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
References: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1371600281-6118-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Vaswani <rvaswani@codeaurora.org>

MSM_TLMM_BASE is currently not mapped by 8x60. Remove it.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Unchanged from previous sends.

 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
index 75a7b62..4f57b43 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
@@ -35,10 +35,6 @@
  *
  */
 
-#define MSM_TLMM_BASE		IOMEM(0xF0004000)
-#define MSM_TLMM_PHYS		0x00800000
-#define MSM_TLMM_SIZE		SZ_16K
-
 #define MSM8X60_TMR_PHYS	0x02000000
 #define MSM8X60_TMR_SIZE	SZ_4K
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
