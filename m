From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Mon, 03 Nov 2014 09:23:10 +0530
Subject: [PATCH 12/12] arm64: Kconfig: Enable PM_GENERIC_DOMAINS for exynos7
In-Reply-To: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1414986790-11940-13-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use power domain driver for Exynos7 SOC's

Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 693db3e..f537558 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -152,6 +152,7 @@ config ARCH_EXYNOS7
 	bool "ARMv8 based Samsung Exynos7"
 	select ARCH_EXYNOS
 	select COMMON_CLK_SAMSUNG
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for Samsung Exynos7 SoC family
 
-- 
1.7.9.5
