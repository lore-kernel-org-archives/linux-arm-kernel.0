From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 9 Oct 2015 19:56:47 +0800
Subject: [PATCH v5 4/7] arm64: berlin: add the pinctrl dependency for Marvell
 Berlin SoCs
In-Reply-To: <1444391810-5045-1-git-send-email-jszhang@marvell.com>
References: <1444391810-5045-1-git-send-email-jszhang@marvell.com>
Message-ID: <1444391810-5045-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to add the pinctrl dependency for Marvell Berlin SoCs.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index c6e2c75..3d17ee2 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -9,6 +9,7 @@ config ARCH_BERLIN
 	bool "Marvell Berlin SoC Family"
 	select ARCH_REQUIRE_GPIOLIB
 	select DW_APB_ICTL
+	select PINCTRL
 	help
 	  This enables support for Marvell Berlin SoC Family
 
-- 
2.6.1
