From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Tue, 27 Nov 2012 17:52:36 +0530
Subject: [PATCH 2/3] arm: exynos5: Enable PM generic domain support in Kconfig
In-Reply-To: <1354018957-17752-1-git-send-email-prasanna.ps@samsung.com>
References: <1354018957-17752-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <1354018957-17752-3-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prasanna Kumar <prasanna.ps@samsung.com>

This patch adds support to enable PM generic domains
under Exynos5 family

Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 945ce49..c07a29c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -63,6 +63,7 @@ config SOC_EXYNOS5250
 	depends on ARCH_EXYNOS5
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
+	select PM_GENERIC_DOMAINS if PM
 	select S5P_DEV_MFC
 	select SAMSUNG_DMADEV
 	help
-- 
1.7.0.4
