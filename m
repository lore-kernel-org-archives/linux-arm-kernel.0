From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 13:04:38 -0800
Subject: [PATCH v2 3/3] ARM: qcom: Drop ARCH_MSM* configs
In-Reply-To: <1448485478-21699-1-git-send-email-sboyd@codeaurora.org>
References: <1448485478-21699-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448485478-21699-4-git-send-email-sboyd@codeaurora.org>
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
index 35a03967d9c2..0945056e3cdf 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -18,16 +18,4 @@ config HAVE_CLKSRC_QCOM
 	  Select this option if you want to support platforms
 	  with the qcom clocksource such as MSM8660 and MSM8960.
 
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
