From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  5 Sep 2012 12:28:56 -0700
Subject: [PATCH 6/9] ARM: msm: Rename board-msm8x60 to signify its DT only
 status
In-Reply-To: <1346873339-10927-1-git-send-email-sboyd@codeaurora.org>
References: <1346873339-10927-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1346873339-10927-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename this file to signify that this board is only supported via
devicetree.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/Makefile                             | 2 +-
 arch/arm/mach-msm/{board-msm8x60.c => board-dt-8660.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/mach-msm/{board-msm8x60.c => board-dt-8660.c} (100%)

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 4ad3969..c4f5169 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o b
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
 obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
 obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
-obj-$(CONFIG_ARCH_MSM8X60) += board-msm8x60.o
+obj-$(CONFIG_ARCH_MSM8X60) += board-dt-8660.o
 obj-$(CONFIG_ARCH_MSM8960) += board-msm8960.o devices-msm8960.o
 
 obj-$(CONFIG_ARCH_MSM7X30) += gpiomux-v1.o gpiomux.o
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-dt-8660.c
similarity index 100%
rename from arch/arm/mach-msm/board-msm8x60.c
rename to arch/arm/mach-msm/board-dt-8660.c
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
