From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Mar 2018 12:23:52 +0800
Subject: [PATCH 0/4] ARM: dts: sun8i: a33: Improvements for A33-OLinuXino
Message-ID: <20180312042356.18625-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some cleanup and improvements for the A33-OLinuXino device
tree. The first two patches drop some unneeded bits. The latter two
enable peripherals that we now support.

ChenYu

Chen-Yu Tsai (4):
  ARM: dts: sun8i: a33: Drop GPIO pinmux settings for A33-OLinuXino
  ARM: dts: sun8i: a33: Drop sunxi-common-regulators.dtsi for
    A33-OLinuXino
  ARM: dts: sun8i: a33: Enable PMIC power supplies on A33-OLinuXino
  ARM: dts: sun8i: a33: Enable A33 internal audio codec on A33-OLinuXino

 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 55 ++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 23 deletions(-)

-- 
2.16.2
