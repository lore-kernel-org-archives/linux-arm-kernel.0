From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 18 Oct 2016 09:43:04 +0200
Subject: [PATCH 3/3] ARM: socfpga: defconfig: enable qspi
In-Reply-To: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
References: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
Message-ID: <20161018074304.6744-3-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/configs/socfpga_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 9f84be5b3ac5..466050663c86 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -50,6 +50,9 @@ CONFIG_CAN_DEBUG_DEVICES=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=8192
-- 
2.9.3
