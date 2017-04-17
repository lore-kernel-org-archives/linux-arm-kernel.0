From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Apr 2017 14:46:38 +0200
Subject: [PATCH v2 0/7] ARM: SPEAr600 updates
Message-ID: <1492433205-13376-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Mike, Stephen,

Here are a set of patches touching the support of the SPEAr600
platform, for which the platform maintained Viresh Kumar has Acked the
patches, but would like the arm-soc and clk maintainers to pick up the
patches directly, see
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/501653.html.

Arnd, Olof, could you pick patches 1 to 6 directly in your arm-soc tree ?

Mike, Stephen, could you pick patch 7 directly in your clk tree ?

Thanks a lot,

Thomas Petazzoni

Thomas Petazzoni (7):
  arm: spear6xx: add labels to various nodes in spear600.dtsi
  arm: spear6xx: use node labels in spear600-evb.dts
  arm: spear6xx: fix spaces in spear600-evb.dts
  arm: spear6xx: switch spear600-evb to the new flash partition DT
    binding
  arm: spear6xx: remove unneeded pinctrl properties in spear600-evb
  arm: spear6xx: add DT description of the ADC on SPEAr600
  clk: spear: fix ADC clock definition on SPEAr600

 arch/arm/boot/dts/spear600-evb.dts | 148 ++++++++++++++++++-------------------
 arch/arm/boot/dts/spear600.dtsi    |  28 ++++---
 drivers/clk/spear/spear6xx_clock.c |   2 +-
 3 files changed, 91 insertions(+), 87 deletions(-)

-- 
2.7.4
