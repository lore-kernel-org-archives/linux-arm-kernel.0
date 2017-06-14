From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jun 2017 22:28:29 +0200
Subject: [GIT PULL] Allwinner H5 changes for 4.13
Message-ID: <20170614202829.us4uiajxb54bavh2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Just like the H3 PR, this one is built on a common branch (up to
0eba511a3cac), but this part should go through arm64.

Thanks!
Maxime

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-h5-for-4.13

for you to fetch changes up to ea43d9b85acf66eac16ec89dc0fb84751f50f088:

  arm64: allwinner: h5: Add initial Orangepi Zero Plus 2 support (2017-06-13 09:18:31 +0200)

----------------------------------------------------------------
Allwinner H5 DT changes for 4.13

Just like the H3, this is mostly about enabling the EMAC on the H5, and
also has a new board, the Orange Pi Zero Plus 2

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: sunxi: h3-h5: Convert R_CCU raw numbers to macros

Corentin Labbe (3):
      arm: sun8i: sunxi-h3-h5: Add dt node for the syscon control module
      arm: sun8i: sunxi-h3-h5: add dwmac-sun8i ethernet driver
      arm64: allwinner: orangepi-pc2: Enable dwmac-sun8i

Icenowy Zheng (5):
      arm64: allwinner: h5: add support for Orange Pi Prime board
      arm64: allwinner: h5: add support for NanoPi NEO2 board
      arm64: allwinner: h5: sort the device nodes in / part for some boards
      arm64: allwinner: h5: enable dwmac-sun8i for Orange Pi Prime
      arm64: allwinner: h5: enable dwmac-sun8i for Nano Pi NEO2

Jagan Teki (1):
      arm64: allwinner: h5: Add initial Orangepi Zero Plus 2 support

 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  48 ++++-
 arch/arm64/boot/dts/allwinner/Makefile             |   3 +
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 161 ++++++++++++++
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |  27 +++
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     | 232 +++++++++++++++++++++
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  92 ++++++++
 6 files changed, 560 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/f84c5e86/attachment.sig>
