From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Fri, 9 Nov 2018 02:08:07 +0100
Subject: [PATCH v3 8/9] arm64: defconfig: Change SCSI_UFS_HISI=m
In-Reply-To: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Message-ID: <2f3fdfc8-24ef-734b-7c4a-76da9f7556be@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCSI_UFS_HISI depends on SCSI_UFSHCD_PLATFORM=m

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2662f83c481c..2e173978eef8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -223,7 +223,7 @@ CONFIG_SCSI_HISI_SAS_PCI=y
 CONFIG_SCSI_UFSHCD=m
 CONFIG_SCSI_UFSHCD_PLATFORM=m
 CONFIG_SCSI_UFS_QCOM=m
-CONFIG_SCSI_UFS_HISI=y
+CONFIG_SCSI_UFS_HISI=m
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
-- 
2.8.2
