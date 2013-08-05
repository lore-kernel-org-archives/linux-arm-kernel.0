From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Mon,  5 Aug 2013 16:02:59 -0700
Subject: [PATCH 2/2] defconfig: msm_defconfig: Enable CONFIG_ARCH_MSM8974
In-Reply-To: <1375743779-24993-1-git-send-email-rvaswani@codeaurora.org>
References: <1375743779-24993-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <1375743779-24993-2-git-send-email-rvaswani@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables MSM8974 build support.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
---
 arch/arm/configs/msm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index 690b5f9..0ed32e5 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -20,6 +20,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MSM=y
 CONFIG_ARCH_MSM8X60=y
 CONFIG_ARCH_MSM8960=y
+CONFIG_ARCH_MSM8974=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
