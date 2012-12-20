From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Thu, 20 Dec 2012 17:56:17 +0530
Subject: [PATCH v2 2/3] arm: exynos5: Enable PM generic domain support in
 Kconfig
In-Reply-To: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
References: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
Message-ID: <1356006378-17441-3-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to enable PM generic domains
under Exynos5 family

Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
---
 This patch is same as v1
 arch/arm/mach-exynos/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 91d5b6f..1c77f17 100644
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
