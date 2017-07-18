From: john.garry@huawei.com (John Garry)
Date: Tue, 18 Jul 2017 19:44:57 +0800
Subject: [PATCH] arm64: defconfig: enable SCSI_HISI_SAS_PCI
Message-ID: <1500378297-74232-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HiSilicon SAS controller based on PCI device,
which is included in hip08 SoC.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c7d147..542838c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -164,6 +164,7 @@ CONFIG_EEPROM_AT25=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SAS_ATA=y
 CONFIG_SCSI_HISI_SAS=y
+CONFIG_SCSI_HISI_SAS_PCI=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
-- 
1.9.1
