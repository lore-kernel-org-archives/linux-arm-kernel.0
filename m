From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 18 Oct 2016 13:40:02 -0700
Subject: [PATCH v3] arm64: defconfig: enable EEPROM_AT25 config option
Message-ID: <1476823202-8286-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for on board SPI EEPROM by setting
CONFIG_EEPROM_AT25=m

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf485..4c62662 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -136,6 +136,7 @@ CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
+CONFIG_EEPROM_AT25=m
 CONFIG_SRAM=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
-- 
2.5.0
