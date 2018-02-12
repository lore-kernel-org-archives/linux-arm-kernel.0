From: joel@jms.id.au (Joel Stanley)
Date: Mon, 12 Feb 2018 18:13:19 +1030
Subject: [PATCH 0/6] ARM: dts: aspeed: Enable iBT and LPC, Palmetto fixes
Message-ID: <20180212074325.23436-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These changes enable recently (and not-so-recently) upstreamed drivers
for the ASPEED BMC device trees.

Palmetto also has some updates that bring it close to being able to boot
a host with an upstream kernel.

I will merge them through the ASPEED tree once they have been reviewed.

Joel Stanley (6):
  ARM: dts: aspeed: Add IPMI BT node
  ARM: dts: aspeed: Enable IPMI BT node on OpenPower machines
  ARM: dts: aspeed-g5: Update LPC node
  ARM: dts: aspeed: Add LPC clock phandles
  ARM: dts: palmetto: Add LEDs and GPIO keys
  ARM: dts: aspeed: Add Palmetto GPIO hogs

 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts    | 188 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts     |   4 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |   4 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts       |   4 +
 arch/arm/boot/dts/aspeed-g4.dtsi                 |   8 +
 arch/arm/boot/dts/aspeed-g5.dtsi                 |  15 +-
 6 files changed, 219 insertions(+), 4 deletions(-)

-- 
2.15.1
