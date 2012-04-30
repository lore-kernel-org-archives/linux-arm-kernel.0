From: riverful.kim@samsung.com (HeungJun, Kim)
Date: Mon, 30 Apr 2012 20:24:41 +0900
Subject: ARM: Exynos4: NURI: Remove redundant S5P_SETUP_MIPIPHY configuration
Message-ID: <1335785081-5398-1-git-send-email-riverful.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "HeungJun, Kim" <riverful.kim@samsung.com>

Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index eb35b8a..0f9bbca 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -297,7 +297,6 @@ config MACH_NURI
 	select S5P_DEV_G2D
 	select S5P_DEV_MFC
 	select S5P_DEV_USB_EHCI
-	select S5P_SETUP_MIPIPHY
 	select S3C_DEV_USB_HSOTG
 	select EXYNOS4_DEV_DMA
 	select EXYNOS_DEV_DRM
-- 
1.7.5.4
