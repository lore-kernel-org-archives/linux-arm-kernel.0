From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Mon, 24 Nov 2014 18:34:16 +0530
Subject: [PATCH RFC v2 12/12] arm64: Kconfig: Enable PM_GENERIC_DOMAINS for
 exynos7
In-Reply-To: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1416834256-11225-12-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use power domain driver for Exynos7 SOC's

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 30bd4d5..b102d0b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -154,6 +154,7 @@ config ARCH_EXYNOS7
 	bool "ARMv8 based Samsung Exynos7"
 	select ARCH_EXYNOS
 	select COMMON_CLK_SAMSUNG
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for Samsung Exynos7 SoC family
 
-- 
1.7.9.5
