From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 29 Apr 2015 10:21:51 +0200
Subject: [PATCH 0/4] A10s Olinuxino Micro DT SPI patches
Message-ID: <cover.1430295711.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

this adds spi2 bus on A10s Olinuxino Micro board.

Thanks

Michal


Michal Suchanek (4):
  ARM: dts: sunxi: sun5i: add spi2_pins_b.
  ARM: dts: sunxi: sun5i-a10s: add spi2_pins_a.
  ARM: dts: sunxi: A10s Olinuxino Micro: add spi2.
  ARM: dts: sunxi: Add SPI aliases on A10s Olinuxino.

 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 9 +++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 8 ++++++++
 arch/arm/boot/dts/sun5i.dtsi                     | 7 +++++++
 3 files changed, 24 insertions(+)

-- 
2.1.4
