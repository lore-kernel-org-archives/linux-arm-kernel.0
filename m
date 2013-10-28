From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 11:02:04 -0700
Subject: [PATCH 6/6] ARM: msm_defconfig: Enable MSM clock drivers
In-Reply-To: <1382983324-31155-1-git-send-email-sboyd@codeaurora.org>
References: <1382983324-31155-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1382983324-31155-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/configs/msm_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index c5698b7..44c1657 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -117,6 +117,9 @@ CONFIG_USB_GADGET_VBUS_DRAW=500
 CONFIG_NEW_LEDS=y
 CONFIG_RTC_CLASS=y
 CONFIG_STAGING=y
+CONFIG_COMMON_CLK_MSM=y
+CONFIG_MSM_MMCC_8960=y
+CONFIG_MSM_GCC_8974=y
 CONFIG_MSM_IOMMU=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
