From: liwei213@huawei.com (Li Wei)
Date: Fri, 13 Oct 2017 15:49:31 +0800
Subject: [PATCH v4 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
Message-ID: <20171013074936.97284-1-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.

Li Wei (5):
  scsi: ufs: add Hisilicon ufs driver code
  dt-bindings: scsi: ufs: add document for hisi-ufs
  arm64: dts: add ufs dts node
  arm64: defconfig: enable configs for Hisilicon ufs
  arm64: defconfig: enable f2fs and squashfs

 Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  47 ++
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |   5 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  19 +
 arch/arm64/configs/defconfig                       |  11 +
 drivers/scsi/ufs/Kconfig                           |   9 +
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/ufs-hisi.c                        | 625 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-hisi.h                        | 161 ++++++
 8 files changed, 878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 create mode 100644 drivers/scsi/ufs/ufs-hisi.c
 create mode 100644 drivers/scsi/ufs/ufs-hisi.h

-- 
2.11.0
