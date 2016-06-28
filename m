From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 28 Jun 2016 13:51:45 +0800
Subject: [PATCH 4/4] arm64: defconfig: Enable Hisi SAS and HNS
In-Reply-To: <1467093105-1568-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1467093105-1568-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1467093105-1568-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Hisi SAS and HNS config for D02/D03 board.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/configs/defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d..3404bbc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -103,7 +103,8 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
-# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_SCSI_SAS_ATA=y
+CONFIG_SCSI_HISI_SAS=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
@@ -120,6 +121,8 @@ CONFIG_TUN=y
 CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
+CONFIG_HNS_DSAF=y
+CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IGBVF=y
-- 
1.7.12.4
