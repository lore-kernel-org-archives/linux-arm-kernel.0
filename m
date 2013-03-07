From: davidb@codeaurora.org (David Brown)
Date: Wed,  6 Mar 2013 16:29:46 -0800
Subject: [PATCH 5/6] ARM: msm: enable SSBI driver in defconfig
In-Reply-To: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1362616187-21089-6-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/configs/msm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index 3a5e519..e6aadbd 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -84,6 +84,7 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_SPI=y
+CONFIG_MSM_SSBI=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
