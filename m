From: butao@hisilicon.com (Bu Tao)
Date: Fri, 16 Jun 2017 14:51:18 +0800
Subject: [PATCH v2 4/5] arm64: defconfig: enable configs for hi3660 ufs
In-Reply-To: <20170616065119.10704-1-butao@hisilicon.com>
References: <20170616065119.10704-1-butao@hisilicon.com>
Message-ID: <20170616065119.10704-5-butao@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enable configs for Hi3660 UFS driver.

Reviewed-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Chen Jun <chenjun14@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 65cdd878cfbd..379c942fe114 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -158,6 +158,9 @@ CONFIG_EEPROM_AT25=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SAS_ATA=y
 CONFIG_SCSI_HISI_SAS=y
+CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFSHCD_PLATFORM=y
+CONFIG_SCSI_UFS_HI3660=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
-- 
2.11.GIT
