From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 19 Oct 2015 17:29:39 +0530
Subject: [PATCH v2] ARM: exynos_defconfig: Increase CONFIG_BLK_DEV_RAM_SIZE to
 64MiB
Message-ID: <1445255979-22217-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_BLK_DEV_RAM_SIZE is currently set to 8MiB, which is a bit on the
smaller side, lets bump it up to 64MiB so that a bigger RAM_DISK can
be used with defconfig.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/configs/exynos_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 1ff2bfa2e183..fa5dfa92d294 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
-- 
1.7.10.4
