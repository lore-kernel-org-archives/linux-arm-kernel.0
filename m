From: liwei213@huawei.com (Li Wei)
Date: Mon, 2 Jul 2018 17:35:47 +0800
Subject: [PATCH v11 4/4] arm64: defconfig: enable configs for Hisilicon ufs
In-Reply-To: <20180702093547.39507-1-liwei213@huawei.com>
References: <20180702093547.39507-1-liwei213@huawei.com>
Message-ID: <20180702093547.39507-5-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9a186f6af8a..2c07e233012b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -193,6 +193,7 @@ CONFIG_SCSI_HISI_SAS=y
 CONFIG_SCSI_HISI_SAS_PCI=y
 CONFIG_SCSI_UFSHCD=m
 CONFIG_SCSI_UFSHCD_PLATFORM=m
+CONFIG_SCSI_UFS_HISI=y
 CONFIG_SCSI_UFS_QCOM=m
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
-- 
2.15.0
