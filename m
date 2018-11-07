From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 23:40:40 +0100
Subject: [PATCH v2 8/9] arm64: defconfig: Change SCSI_UFS_HISI=m
In-Reply-To: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
Message-ID: <38ca31d9-bcfe-36dd-a6ab-4fd376e4a12d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCSI_UFS_HISI depends on SCSI_UFSHCD_PLATFORM=m

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e4957df18f23..75d5ed7ea53d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -222,7 +222,7 @@ CONFIG_SCSI_HISI_SAS_PCI=y
 CONFIG_SCSI_UFSHCD=m
 CONFIG_SCSI_UFSHCD_PLATFORM=m
 CONFIG_SCSI_UFS_QCOM=m
-CONFIG_SCSI_UFS_HISI=y
+CONFIG_SCSI_UFS_HISI=m
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
-- 
2.17.1
