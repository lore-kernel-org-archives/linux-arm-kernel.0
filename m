From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jun 2017 21:59:04 +0200
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.13
Message-ID: <20170614195904.w3dnuzscvvdjq4vp@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is our usual bunch of arm64 DT patches for 4.13

Thanks!
Maxime

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.13

for you to fetch changes up to bdecc9cb214e25938098111aa994da050b7251a6:

  arm64: allwinner: a64: Add initial Orangepi Win/WinPlus support (2017-06-13 09:17:44 +0200)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.13

Our usual arm64 changes. The most notable things are the EMAC support and
USB support enhancements. There's also support for the SoPine SoM, and the
OrangePi Win.

----------------------------------------------------------------
Andreas F?rber (3):
      arm64: dts: allwinner: a64: Add UART2 pin nodes
      arm64: dts: allwinner: pine64: Add remaining UART aliases
      arm64: dts: allwinner: pine64: Prepare optional UART nodes with pinctrl

Chen-Yu Tsai (1):
      arm64: allwinner: a64: Convert CCU raw number references to macros

Corentin Labbe (5):
      arm64: allwinner: sun50i-a64: Add dt node for the syscon control module
      arm64: allwinner: sun50i-a64: add dwmac-sun8i Ethernet driver
      arm64: allwinner: pine64: Enable dwmac-sun8i
      arm64: allwinner: pine64-plus: Enable dwmac-sun8i
      arm64: allwinner: bananapi-m64: Enable dwmac-sun8i

Icenowy Zheng (5):
      arm64: allwinner: a64: add EHCI0/OHCI0 nodes to A64 DTSI
      arm64: allwinner: a64: enable EHCI0/OHCI0 for Pine64
      arm64: allwinner: a64: enable RSB on A64
      arm64: allwinner: a64: add DTSI file for SoPine SoM
      arm64: allwinner: a64: add device tree for SoPine with baseboard

Jagan Teki (1):
      arm64: allwinner: a64: Add initial Orangepi Win/WinPlus support

 arch/arm64/boot/dts/allwinner/Makefile             |   2 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  15 +++
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  95 ++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  17 ++-
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  57 +++++++++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 126 +++++++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      |  65 ++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 137 ++++++++++++++++++---
 8 files changed, 496 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/88585f84/attachment-0001.sig>
