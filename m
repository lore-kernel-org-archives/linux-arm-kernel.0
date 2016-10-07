From: scott.branden@broadcom.com (Scott Branden)
Date: Fri,  7 Oct 2016 14:23:52 -0700
Subject: [PATCH] arm64: defconfig: enable EEPROM_AT25 config option
Message-ID: <1475875432-13627-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for on board SPI EEPROM by turning on
CONFIG_EEPROM_AT25.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf485..9955ee1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -136,6 +136,7 @@ CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
+CONFIG_EEPROM_AT25=y
 CONFIG_SRAM=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
-- 
2.5.0
