From: monstr@monstr.eu (Michal Simek)
Date: Fri, 18 Jul 2014 12:34:16 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v3.17
Message-ID: <53C8F828.8000804@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these two patches to your arm-soc tree.

Thanks,
Michal

The following changes since commit 1795cd9b3a91d4b5473c97f491d63892442212ab:

  Linux 3.16-rc5 (2014-07-13 14:04:33 -0700)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-for-3.17

for you to fetch changes up to 8fe9346b945d76ddb3f08c00e34d701174c62fa0:

  ARM: zynq: DT: Migrate UART to Cadence binding (2014-07-18 11:54:24 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.17

- Document and use new cadence serial binding

----------------------------------------------------------------
Soren Brinkmann (2):
      tty: cadence: Document DT binding
      ARM: zynq: DT: Migrate UART to Cadence binding

 Documentation/devicetree/bindings/serial/cdns,uart.txt | 20 ++++++++++++++++++++
 arch/arm/boot/dts/zynq-7000.dtsi                       |  8 ++++----
 2 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/99d358e5/attachment-0001.sig>
