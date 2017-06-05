From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  5 Jun 2017 21:21:25 +0200
Subject: [PATCH 0/5] ARM: sunxi: Enable dwmac-sun8i on more boards
Message-ID: <20170605192130.25320-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This serie enable dwmac-sun8i on more boards.
The first 3 patch enable dwmac-sun8i on some h3/h5 boards.
The last 2 add dwmac-sun8i on a83t.

Corentin Labbe (5):
  ARM: sun8i: orangepi-plus: Enable dwmac-sun8i
  ARM: sun8i: bananapi-m2-plus: Enable dwmac-sun8i
  ARM: sun50i: orangepi-pc2: Enable dwmac-sun8i
  ARM: sun8i: a83t: Add dt node for the syscon control module
  ARM: sun8i: a83t: add dwmac-sun8i ethernet driver

 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 34 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 29 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       | 32 ++++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 27 +++++++++++++++++
 4 files changed, 122 insertions(+)

-- 
2.13.0
