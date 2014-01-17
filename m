From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Jan 2014 17:25:04 -0800
Subject: [PATCH 2/2] ARM: msm_defconfig: Enable MSM clock drivers
In-Reply-To: <1389921904-3777-1-git-send-email-sboyd@codeaurora.org>
References: <1389921904-3777-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389921904-3777-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to probe the clock controller devices and boot to a
serial console on all DT enabled MSM platforms.

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/configs/msm_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index 0219c65cefd5..c5858b9eb516 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -114,6 +114,10 @@ CONFIG_USB_GADGET_VBUS_DRAW=500
 CONFIG_NEW_LEDS=y
 CONFIG_RTC_CLASS=y
 CONFIG_STAGING=y
+CONFIG_COMMON_CLK_QCOM=y
+CONFIG_MSM_GCC_8660=y
+CONFIG_MSM_MMCC_8960=y
+CONFIG_MSM_MMCC_8974=y
 CONFIG_MSM_IOMMU=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
