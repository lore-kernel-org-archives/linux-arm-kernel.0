From: monstr@monstr.eu (Michal Simek)
Date: Mon, 8 Jan 2018 14:02:18 +0100
Subject: [GIT PULL] ARM64: Xilinx ZynqMP SoC patches for v4.16
Message-ID: <84cfd3d5-f0e7-23dc-0e33-430a1f2dbdb0@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

please consider to pull these 3 patches to your tree. I have discussed
it with Arnd that this could be probably fine even it is a little bit late.

Thanks,
Michal


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-4.16

for you to fetch changes up to cee8113a295acfc4cd25728d7c3d44e6bc3bbff9:

  soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
(2018-01-08 13:42:47 +0100)

----------------------------------------------------------------
arm: Xilinx ZynqMP SoC patches for v4.16

- Create drivers/soc/xilinx folder structure
- Add ZynqMP vcu init driver

----------------------------------------------------------------
Dhaval Shah (2):
      dt-bindings: soc: xilinx: Add DT bindings to xlnx_vcu driver
      soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver

Michal Simek (1):
      soc: xilinx: Create folder structure for soc specific drivers

 Documentation/devicetree/bindings/soc/xilinx/xlnx,vcu.txt |  31 ++++++++
 drivers/soc/Kconfig                                       |   1 +
 drivers/soc/Makefile                                      |   1 +
 drivers/soc/xilinx/Kconfig                                |  19 +++++
 drivers/soc/xilinx/Makefile                               |   2 +
 drivers/soc/xilinx/xlnx_vcu.c                             | 630
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 684 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/soc/xilinx/xlnx,vcu.txt
 create mode 100644 drivers/soc/xilinx/Kconfig
 create mode 100644 drivers/soc/xilinx/Makefile
 create mode 100644 drivers/soc/xilinx/xlnx_vcu.c



-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180108/739c9cba/attachment.sig>
