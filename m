From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Jan 2017 15:27:25 -0800
Subject: [PATCH 4/5] ARM: qcom_defconfig: Drop SoC specific configs
In-Reply-To: <20170118232726.22876-1-sboyd@codeaurora.org>
References: <20170118232726.22876-1-sboyd@codeaurora.org>
Message-ID: <20170118232726.22876-5-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that these configs are gone let's remove them from the
defconfig.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c3a0108a231..03fc52964902 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -20,10 +20,6 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_QCOM=y
-CONFIG_ARCH_MSM8X60=y
-CONFIG_ARCH_MSM8960=y
-CONFIG_ARCH_MSM8974=y
-CONFIG_ARCH_MDM9615=y
 CONFIG_SMP=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_PREEMPT=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
