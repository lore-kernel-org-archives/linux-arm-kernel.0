From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Jul 2015 14:43:43 +0000
Subject: [PATCH 5/5] ARM: prima2_defconfig: enable build for hwspinlock
Message-ID: <1436798623-4356-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This patch enables hardware spinlock driver for CSRatlas7 platforms.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/configs/prima2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index a9c1c33..7cc8e8e 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -50,6 +50,7 @@ CONFIG_DMADEVICES=y
 CONFIG_DMADEVICES_DEBUG=y
 CONFIG_DMADEVICES_VDEBUG=y
 CONFIG_SIRF_DMA=y
+CONFIG_HWSPINLOCK_SIRF=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.3.5
