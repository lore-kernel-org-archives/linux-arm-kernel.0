From: monstr@monstr.eu (Michal Simek)
Date: Mon, 21 Aug 2017 15:05:55 +0200
Subject: [GIT PULL] ARM: Xilinx Zynq SoC patches for v4.14
Message-ID: <8d0c07a6-27e9-e14a-560f-3fc89327f8cd@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please apply these two patches to your tree.

Thanks,
Michal


 The following changes since commit
5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

 are available in the git repository at:

   https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.14

 for you to fetch changes up to b04d4c876b1b7f25cff35b7c26c5b9f518f612b2:

   ARM: zynq: Add support for Zynq-7000S devices (2017-08-21 14:22:50 +0200)

 ----------------------------------------------------------------
 arm: Xilinx Zynq patches for v4.14

 - Add support for 7000s devices

 ----------------------------------------------------------------
 Michal Simek (2):
       devicetree: ARM: zynq: Add DT binding for eFuse controller
       ARM: zynq: Add support for Zynq-7000S devices

  Documentation/devicetree/bindings/nvmem/zynq-efuse.txt | 15
+++++++++++++++
  arch/arm/boot/dts/zynq-7000.dtsi                       |  5 +++++
  arch/arm/mach-zynq/Makefile                            |  2 +-
  arch/arm/mach-zynq/common.c                            |  1 +
  arch/arm/mach-zynq/common.h                            |  3 +++
  arch/arm/mach-zynq/efuse.c                             | 75
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/mach-zynq/platsmp.c                           |  3 +++
  7 files changed, 103 insertions(+), 1 deletion(-)
  create mode 100644 Documentation/devicetree/bindings/nvmem/zynq-efuse.txt
  create mode 100644 arch/arm/mach-zynq/efuse.c

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/a8594170/attachment-0001.sig>
