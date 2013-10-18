From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Oct 2013 10:56:46 -0700
Subject: [PATCH v2 4/4] ARM: msm_defconfig: Enable restart driver
In-Reply-To: <1382119006-22231-1-git-send-email-sboyd@codeaurora.org>
References: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
 <1382119006-22231-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1382119006-22231-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/configs/msm_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index 0ed32e5..c5698b7 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -89,6 +89,8 @@ CONFIG_SSBI=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_MSM=y
 CONFIG_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_MEDIA_SUPPORT=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
