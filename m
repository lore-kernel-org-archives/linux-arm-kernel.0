From: monstr@monstr.eu (Michal Simek)
Date: Thu, 28 May 2015 08:53:45 +0200
Subject: [GIT PULL]Xilinx Zynq DT changes for v4.2
Message-ID: <5566BB79.4010901@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these patches to your tree.
I have added patch which add CEVA to vendor-prefixes after my IRC with Arnd.

Thanks,
Michal


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-4.2

for you to fetch changes up to 4481b18b7cf023c57085b3c7db762dc4d7f1873b:

  ARM: zynq: DT: Use the zynq binding with macb (2015-05-28 08:47:28 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v4.2

- Fix aliases and stdout properties
- Document current TTC binding
- Add Ceva to prefixes
- Use new compatible string for MACB

----------------------------------------------------------------
Michal Simek (4):
      ARM: dts: zynq: Add missing alias node for zybo and parallella
      ARM: dts: zynq: Fix stdout-path and bootargs
      PCI: xilinx: Trivial fix in DT example
      of: Add vendor prefix for Ceva

Nathan Sullivan (1):
      ARM: zynq: DT: Use the zynq binding with macb

Peter Crosthwaite (1):
      devicetree: cadence_ttc: Document binding for timer width

 Documentation/devicetree/bindings/pci/xilinx-pcie.txt         | 2 +-
 Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt | 4 ++++
 Documentation/devicetree/bindings/vendor-prefixes.txt         | 1 +
 arch/arm/boot/dts/zynq-7000.dtsi                              | 4 ++--
 arch/arm/boot/dts/zynq-parallella.dts                         | 9 +++++++--
 arch/arm/boot/dts/zynq-zc702.dts                              | 3 ++-
 arch/arm/boot/dts/zynq-zc706.dts                              | 3 ++-
 arch/arm/boot/dts/zynq-zed.dts                                | 3 ++-
 arch/arm/boot/dts/zynq-zybo.dts                               | 8 +++++++-
 9 files changed, 28 insertions(+), 9 deletions(-)


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150528/17a22494/attachment.sig>
