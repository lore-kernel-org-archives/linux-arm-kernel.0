From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:55 +0000
Subject: [PATCH 12/13] ARM: spear: adapt defconfig files for multiplatform
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few options have changed slightly, so we have to
make the respective changes here, too.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/spear3xx_defconfig | 2 ++
 arch/arm/configs/spear6xx_defconfig | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 865980c..7ff23a0 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -6,7 +6,9 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
+CONFIG_ARCH_SPEAR3XX=y
 CONFIG_MACH_SPEAR300=y
 CONFIG_MACH_SPEAR310=y
 CONFIG_MACH_SPEAR320=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index a2a1265..7822980 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -6,6 +6,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR6XX=y
 CONFIG_BINFMT_MISC=y
-- 
1.8.0
