From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:20 +0200
Subject: [PATCH v3 00/14] ARM: dts: sunxi: Fix DT build warnings
Message-ID: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

The goal of this patch series is to have a clean DT build with W=1.

Regards

Changes since v1:
- moved i2c2 unit address change from patch #2 in patch #1

Changes since v2
- added two patch for fixing pin names

Corentin Labbe (14):
  ARM: dts: sunxi: h3/h5: Fix simple-bus unit address format error
  ARM: dts: sunxi: h3/h5: Fix i2c2 register address
  ARM: dts: sunxi: h3/h5: Fix node with unit name and no reg property
  ARM: dts: nanopi: Fix node with unit name and no reg property
  ARM: dts: orangepi2: Fix node with unit name and no reg property
  ARM: dts: sun8i: orangepi-lite: Fix node with unit name and no reg
    property
  ARM: dts: sun8i: orangepi one: Fix node with unit name and no reg
    property
  ARM: dts: sun8i: orangepipc: Fix node with unit name and no reg
    property
  ARM: dts: sun8i: orangepi-plus: Fix node with unit name and no reg
    property
  arm64: allwinner: a64: Fix simple-bus unit address format error
  arm64: allwinner: a64: Fix node with unit name and no reg property
  ARM: dts: sun8i: a83t: Fix simple-bus unit address format error
  arm64: allwinner: a64: fix pin name
  ARM: dts: sun8i: fix pin name

 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  6 +-
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  8 +-
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  8 +-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          | 10 +--
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |  4 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |  2 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts      |  4 +-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             | 12 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          | 16 ++--
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 14 ++--
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 10 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |  2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 12 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  2 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 88 +++++++++++-----------
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  2 +-
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |  2 +-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |  2 +-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  2 +-
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  2 +-
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 26 +++----
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   |  6 +-
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |  4 +-
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |  6 +-
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |  8 +-
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  4 +-
 27 files changed, 132 insertions(+), 132 deletions(-)

-- 
2.13.5
