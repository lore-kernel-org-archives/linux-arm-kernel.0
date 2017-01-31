From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 09:59:49 +0100
Subject: [GIT PULL] Allwinner arm64 changes for 4.11
Message-ID: <20170131085949.ej3rpbdtbr563qm5@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt64-for-4.11

for you to fetch changes up to b8bcf0e1b21273584b6829bafe30f2949a062c34:

  arm64: allwinner: add BananaPi-M64 support (2017-01-30 11:37:42 +0100)

----------------------------------------------------------------
Allwinner arm64 changes for 4.11

Some patches related the arm64 Allwinner SoCs, most notably:
  - Support for the MMC
  - Suport for the USB and mUSB controllers
  - New boards: Bananapi M64

----------------------------------------------------------------
Andre Przywara (4):
      arm64: allwinner: a64: Add MMC nodes
      arm64: allwinner: pine64: add MMC support
      arm64: allwinner: a64: add UART1 pin nodes
      arm64: allwinner: add BananaPi-M64 support

Chen-Yu Tsai (1):
      arm64: dts: allwinner: Remove no longer used pinctrl/sun4i-a10.h header

Icenowy Zheng (5):
      arm64: dts: allwinner: add USB1-related nodes of Allwinner A64
      arm64: dts: allwinner: sort the nodes in sun50i-a64-pine64.dts
      arm64: dts: allwinner: enable EHCI1, OHCI1 and USB PHY nodes in Pine64
      arm64: dts: add MUSB node to Allwinner A64 dtsi
      arm64: dts: enable the MUSB controller of Pine64 in host-only mode

Maxime Ripard (2):
      arm64: allwinner: a64: Add MMC pinctrl nodes
      arm64: allwinner: a64: Increase the MMC max frequency

 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 120 ++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  43 ++++++-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 137 ++++++++++++++++++++-
 4 files changed, 297 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/92f077aa/attachment.sig>
