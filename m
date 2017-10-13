From: liwei213@huawei.com (Li Wei)
Date: Fri, 13 Oct 2017 15:49:35 +0800
Subject: [PATCH v4 4/5] arm64: defconfig: enable configs for Hisilicon ufs
In-Reply-To: <20171013074936.97284-1-liwei213@huawei.com>
References: <20171013074936.97284-1-liwei213@huawei.com>
Message-ID: <20171013074936.97284-5-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enable configs for Hisilicon Hixxxx UFS driver.

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34480e9af2e7..8aff981915f5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -168,6 +168,9 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SAS_ATA=y
 CONFIG_SCSI_HISI_SAS=y
 CONFIG_SCSI_HISI_SAS_PCI=y
+CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFSHCD_PLATFORM=y
+CONFIG_SCSI_UFS_HISI=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
-- 
2.11.0
