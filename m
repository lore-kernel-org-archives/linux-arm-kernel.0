From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 17:25:23 -0800
Subject: [PATCH v3 3/3] ARM: qcom: Drop ARCH_MSM* configs
In-Reply-To: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
References: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448933123-9843-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop these configs now that we select the clocksources we need
via the defconfig.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-qcom/Kconfig | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 230c7e8a32fb..9cd3b50d891f 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -23,16 +23,4 @@ config ARCH_QCOM_A_FAMILY
 	  B-family includes all Snapdragon 2xx/4xx/6xx/8xx models starting
 	  in 2013 with the MSM8x74 SoC.
 
-config ARCH_MSM8X60
-	bool "Enable support for MSM8X60"
-	select CLKSRC_QCOM
-
-config ARCH_MSM8960
-	bool "Enable support for MSM8960"
-	select CLKSRC_QCOM
-
-config ARCH_MSM8974
-	bool "Enable support for MSM8974"
-	select HAVE_ARM_ARCH_TIMER
-
 endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
