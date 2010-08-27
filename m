From: konkers@android.com (Erik Gilling)
Date: Fri, 27 Aug 2010 13:13:02 -0700
Subject: [PATCH] [ARM] tegra: Add ZRELADDR default for ARCH_TEGRA
Message-ID: <1282939982-11295-1-git-send-email-konkers@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change-Id: Ic28177a645e2d5bc53099c15dcd5b1ae7f3d5208
Signed-off-by: Erik Gilling <konkers@android.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 771503d..8b0d769 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1602,6 +1602,7 @@ config ZRELADDR
 		ARCH_ORION5X ||\
 		ARCH_SPEAR3XX ||\
 		ARCH_SPEAR6XX ||\
+		ARCH_TEGRA ||\
 		ARCH_U8500 ||\
 		ARCH_VERSATILE ||\
 		ARCH_W90X900
-- 
1.6.5.6
