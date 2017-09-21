From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 21 Sep 2017 19:21:39 +0200
Subject: [PATCH 00/12] ARM: dts: sunxi: Fix DT build warnings
Message-ID: <20170921172151.29779-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

The goal of this patch series is to have a clean DT build with W=1.

Regards

Corentin Labbe (12):
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
  ARM: sun8i: a83t: Fix simple-bus unit address format error

 arch/arm/boot/dts/sun8i-a83t.dtsi             |  6 +-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi        |  8 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts     |  8 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts  |  6 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts   |  6 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts    |  6 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts  |  2 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 88 +++++++++++++--------------
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 24 ++++----
 9 files changed, 77 insertions(+), 77 deletions(-)

-- 
2.13.5
