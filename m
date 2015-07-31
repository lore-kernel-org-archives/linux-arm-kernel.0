From: monstr@monstr.eu (Michal Simek)
Date: Fri, 31 Jul 2015 10:49:35 +0200
Subject: [GIT PULL] Xilinx ZynqMP DT changes for v4.3
Message-ID: <55BB369F.4080100@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these ARM64 DT patches to your tree.

Thanks,
Michal


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.3

for you to fetch changes up to f49310dc62f68ae9f905f9a1e42224fa23867f47:

  ARM64: zynqmp: Move SPI nodes to the right location (2015-07-31
10:46:34 +0200)

----------------------------------------------------------------
arm: Xilinx ZynqMP dt patches for v4.3

- Add SATA, GPIO, CAN, SMMU, USB, SPI, I2C, watchdog and sdhci for zynqmp
- Sort nodes in dtsi

----------------------------------------------------------------
Michal Simek (10):
      ARM64: zynqmp: Use zynqmp specific compatible string for gpio
      ARM64: zynqmp: Add CANs node for platform
      ARM64: zynqmp: Add SMMU support
      ARM64: zynqmp: Add DWC3 usb support
      ARM64: zynqmp: Enable watchdog on ep108
      ARM64: zynqmp: Enable sdhci on ep108
      ARM64: zynqmp: Add eeprom memories on i2c bus
      ARM64: zynqmp: Enable spi flashes on ep108
      ARM64: zynqmp: Move uart and ttcs to the right location
      ARM64: zynqmp: Move SPI nodes to the right location

Suneel Garapati (1):
      devicetree: xilinx: zynqmp: add sata node

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts |  89
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 233
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
 2 files changed, 241 insertions(+), 81 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/d5148d6b/attachment.sig>
