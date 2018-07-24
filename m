From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 15:09:08 +0200
Subject: [GIT PULL] Allwinner H3/H5 changes for 4.19
Message-ID: <20180724130908.lbxaibjov4u223y4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-h3-h5-for-4.19

for you to fetch changes up to 8fb147322a8fdec96852d537affe9623d307edfb:

  ARM: dts: sunxi-h3-h5: Remove unused address-cells/size-cells of dwmac-sun8i (2018-07-19 16:31:04 +0200)

----------------------------------------------------------------
Allwinner H3/H5 changes for 4.19

Our usual bunch of changes shared between arm and arm64.

This time, we have:
  - eMMC support for the ALL-H3-CC boards
  - EMAC support for the Beelink X2

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sunxi: libretech-all-h3-cc: Enable eMMC module

Corentin Labbe (1):
      ARM: dts: sunxi-h3-h5: Remove unused address-cells/size-cells of dwmac-sun8i

Icenowy Zheng (1):
      ARM: sun8i: h3: add SY8113B regulator on Banana Pi M2 Zero board

Marcus Cooper (1):
      ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2

Viresh Kumar (1):
      ARM: dts: sun8i-h3: Add missing cooling device properties for CPUs

 .../arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts           |  7 +++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                     |  9 +++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                  |  2 --
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi    |  9 +++++++++
 5 files changed, 46 insertions(+), 2 deletions(-)

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/02859021/attachment.sig>
