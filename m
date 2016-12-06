From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  6 Dec 2016 14:53:42 +1100
Subject: [PATCH v4 0/6] aspeed: Integrate pinctrl and gpio drivers
Message-ID: <20161206035348.29948-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This picks up some work from a while back that adds pinctrl and GPIO support to
the Aspeed devicetrees. See the previous series:

    https://lkml.org/lkml/2016/8/30/74

Since v3 two new patches have been added, describing the Low Pin Count bus and
SoC Display Controller nodes. These are essential for the aspeed-g5 pinctrl.

Cheers,

Andrew

Andrew Jeffery (6):
  arm: dts: aspeed-g4: Add syscon and pin controller nodes
  arm: dts: aspeed-g4: Add gpio controller to devicetree
  arm: dts: aspeed-g5: Add SoC Display Controller node
  arm: dts: aspeed-g5: Add LPC Controller node
  arm: dts: aspeed-g5: Add syscon and pin controller nodes
  arm: dts: aspeed-g5: Add gpio controller to devicetree

 arch/arm/boot/dts/aspeed-g4.dtsi | 760 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 863 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 1623 insertions(+)

-- 
2.9.3
