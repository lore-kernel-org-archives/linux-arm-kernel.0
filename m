From: liwei213@huawei.com (Li Wei)
Date: Tue, 29 Aug 2017 16:41:11 +0800
Subject: [PATCH v3 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
Message-ID: <20170829084116.106695-1-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board

Li Wei (5):
  scsi: ufs: add Hisilicon ufs driver code
  dt-bindings: scsi: ufs: add document for hisi-ufs
  arm64: dts: add ufs dts node
  arm64: defconfig: enable configs for Hisilicon ufs
  arm64: defconfig: enable f2fs and squashfs

 Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  35 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  16 +
 arch/arm64/configs/defconfig                       |  11 +
 drivers/scsi/ufs/Kconfig                           |   9 +
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/ufs-hisi.c                        | 634 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-hisi.h                        | 163 ++++++
 7 files changed, 869 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 create mode 100644 drivers/scsi/ufs/ufs-hisi.c
 create mode 100644 drivers/scsi/ufs/ufs-hisi.h

-- 
2.11.0
