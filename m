From: monstr@monstr.eu (Michal Simek)
Date: Mon, 21 Aug 2017 14:01:17 +0200
Subject: [GIT PULL] ARM: Xilinx Zynq DT fixes for v4.14
Message-ID: <d3b9ce62-6899-8629-d267-2f08d435281d@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these patches to your tree.

Thanks,
Michal


 The following changes since commit
5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

 are available in the git repository at:

   https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-4.14

 for you to fetch changes up to 21ad06cc9e6399f64447ab316d92142bff7a17dd:

   arm: zynq: Remove earlycon from bootargs (2017-08-21 13:54:42 +0200)

 ----------------------------------------------------------------
 arm: Xilinx Zynq DT fixes for v4.14

 - Remove earlycon
 - Use C pre-processor
 - Add fpga full region
 - Add ethernet-phy as device-type
 - Add adv7511 nodes to zc70x

----------------------------------------------------------------
 Christian Kohn (1):
       arm: zynq: Add adv7511 on i2c bus for zc70x

 Michal Simek (3):
       arm: zynq: Label whole PL part as fpga_full region
       arm: zynq: Use C pre-processor for includes in dts
       arm: zynq: Remove earlycon from bootargs

 Sai Pavan Boddu (1):
       arm: zynq: Add device-type property for zynq ethernet phy nodes

  arch/arm/boot/dts/zynq-7000.dtsi      |  8 ++++++++
  arch/arm/boot/dts/zynq-parallella.dts |  3 ++-
  arch/arm/boot/dts/zynq-zc702.dts      | 20 ++++++++++++++++++--
  arch/arm/boot/dts/zynq-zc706.dts      | 20 ++++++++++++++++++--
  arch/arm/boot/dts/zynq-zed.dts        |  5 +++--
  arch/arm/boot/dts/zynq-zybo.dts       |  5 +++--
  6 files changed, 52 insertions(+), 9 deletions(-)
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/b5d8a356/attachment-0001.sig>
