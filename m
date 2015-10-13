From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 13 Oct 2015 08:58:14 +0800
Subject: [PATCH v2 2/4] arm64: Kconfig: select sp804 timer for ARCH_HISI
In-Reply-To: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
References: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1444697896-4323-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select sp804 timer for ARCH_HISI, which is used as broadcast timer.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 23800a1..6d730fb 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -35,6 +35,7 @@ config ARCH_FSL_LS2085A
 
 config ARCH_HISI
 	bool "Hisilicon SoC Family"
+	select ARM_TIMER_SP804
 	help
 	  This enables support for Hisilicon ARMv8 SoC family
 
-- 
1.9.1
