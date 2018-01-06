From: liwei213@huawei.com (Li Wei)
Date: Sat, 6 Jan 2018 17:51:12 +0800
Subject: [PATCH v7 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
Message-ID: <20180106095117.67907-1-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.

Li Wei (5):
  scsi: ufs: add Hisilicon ufs driver code
  dt-bindings: scsi: ufs: add document for hisi-ufs
  arm64: dts: add ufs dts node
  arm64: defconfig: enable configs for Hisilicon ufs
  arm64: defconfig: enable f2fs and squashfs

 Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  43 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  20 +
 arch/arm64/configs/defconfig                       |  11 +
 drivers/scsi/ufs/Kconfig                           |   9 +
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/ufs-hisi.c                        | 621 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-hisi.h                        | 116 ++++
 7 files changed, 821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 create mode 100644 drivers/scsi/ufs/ufs-hisi.c
 create mode 100644 drivers/scsi/ufs/ufs-hisi.h

-- 
2.15.0
