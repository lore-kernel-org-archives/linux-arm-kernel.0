From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jun 2016 18:07:51 -0700
Subject: [PATCH] arm64: defconfig: Enable qcom msm8996 clk drivers
Message-ID: <20160616010751.11629-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the clk drivers on msm8996. This allows us to boot and
test most device drivers on this SoC.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b08ae478c9e7..d2975e6c3c3f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -297,6 +297,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
+CONFIG_MSM_MMCC_8996=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_MAILBOX=y
 CONFIG_ARM_MHU=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
