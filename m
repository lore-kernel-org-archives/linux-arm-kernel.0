From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 17:25:22 -0800
Subject: [PATCH v3 2/3] ARM: qcom_defconfig: Enable HAVE_ARM_ARCH_TIMER
In-Reply-To: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
References: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448933123-9843-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable this config in the defconfig so that we can delete the
selection logic surrounding it that exists in mach-qcom/Kconfig.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index ee54a706e8a3..6f34da7afd75 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -22,6 +22,7 @@ CONFIG_ARCH_MSM8X60=y
 CONFIG_ARCH_MSM8960=y
 CONFIG_ARCH_MSM8974=y
 CONFIG_SMP=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
