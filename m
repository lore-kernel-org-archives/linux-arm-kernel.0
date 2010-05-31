From: leiwen@marvell.com (Lei Wen)
Date: Mon, 31 May 2010 14:57:49 +0800
Subject: [PATCH 11/29] mmp: add nand support to pxa168
Message-ID: <mailman.111.1280296698.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/configs/pxa168_defconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/pxa168_defconfig
b/arch/arm/configs/pxa168_defconfig
index 113511f..a01ea99 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -438,7 +438,14 @@ CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_PXA3xx=y
 # CONFIG_PARPORT is not set
 # CONFIG_BLK_DEV is not set
 # CONFIG_MISC_DEVICES is not set
-- 
1.7.0.4
