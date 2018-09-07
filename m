From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  7 Sep 2018 12:59:24 +1200
Subject: [PATCH 0/2] ARM: dts: mvebu: marvell,prestera
Message-ID: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a generic compatible string so that drivers don't need to deal with the
specific variants.

Chris Packham (2):
  dt-bindings: marvell,prestera: Add common compatible string
  ARM: dts: mvebu: add "marvell,prestera" to PP nodes

 Documentation/devicetree/bindings/net/marvell,prestera.txt | 4 ++--
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi                  | 2 +-
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi                  | 2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi                  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.18.0
