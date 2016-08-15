From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 15 Aug 2016 15:03:45 +0800
Subject: [PATCH v3 5/5] arm64: defconfig: Enable Hisi SAS and HNS
In-Reply-To: <1471244625-56331-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1467170878-24030-1-git-send-email-wangkefeng.wang@huawei.com>
 <1471244625-56331-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1471244625-56331-6-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Hisi SAS and HNS config for D02/D03 board.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/configs/defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf485..10cab2f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -139,7 +139,8 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_SRAM=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
-# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_SCSI_SAS_ATA=y
+CONFIG_SCSI_HISI_SAS=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
@@ -160,6 +161,8 @@ CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_MACB=y
+CONFIG_HNS_DSAF=y
+CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IGBVF=y
-- 
1.7.12.4
