From: liwei213@huawei.com (Li Wei)
Date: Tue, 17 Apr 2018 22:08:13 +0800
Subject: [PATCH v9 4/5] arm64: defconfig: enable configs for Hisilicon ufs
In-Reply-To: <20180417140814.38098-1-liwei213@huawei.com>
References: <20180417140814.38098-1-liwei213@huawei.com>
Message-ID: <20180417140814.38098-5-liwei213@huawei.com>
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
index ecf613761e78..d42b1ecaf490 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -187,6 +187,9 @@ CONFIG_BLK_DEV_SD=y
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
2.15.0
