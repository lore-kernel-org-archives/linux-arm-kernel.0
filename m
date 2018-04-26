From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Apr 2018 12:29:41 +0200
Subject: [PATCH 00/10] ARM, arm64: dts: renesas: update register properties
Message-ID: <20180426102951.8683-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series:

1. Drops unnecessary address properties from VIN port nodes
   on Renesas R-Car Gen2 SoC board DTSes. These are unnecessary
   as the nodes to not have bus addresses.

2. And adds address properties to R-Car Sound port nodes on
   Renesas R-Car Gen2 SoC DTSes. These are necessary as the nodes
   have unit names.

Simon Horman (10):
  ARM: dts: lager: Drop unnecessary address properties from port node
  ARM: dts: porter: Drop unnecessary address properties from vin port
    node
  ARM: dts: gose: Drop unnecessary address properties from port nodes
  ARM: dts: koelsch: Drop unnecessary address properties from port nodes
  ARM: dts: alt: Drop unnecessary address properties from vin port node
  ARM: dts: silk: Drop unnecessary address properties from vin port node
  ARM: dts: kzm9d: Drop unnecessary address properties from gpio_keys
    node
  arm64: dts: renesas: r8a7795: Add address properties to rcar_sound
    port nodes
  arm64: dts: renesas: r8a7796: Add address properties to rcar_sound
    port nodes
  arm64: dts: renesas: r8a77965: Add address properties to rcar_sound
    port nodes

 arch/arm/boot/dts/emev2-kzm9d.dts         |  3 ---
 arch/arm/boot/dts/r8a7790-lager.dts       |  3 ---
 arch/arm/boot/dts/r8a7791-koelsch.dts     |  6 ------
 arch/arm/boot/dts/r8a7791-porter.dts      |  3 ---
 arch/arm/boot/dts/r8a7793-gose.dts        |  6 ------
 arch/arm/boot/dts/r8a7794-alt.dts         |  3 ---
 arch/arm/boot/dts/r8a7794-silk.dts        |  3 ---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 14 ++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 11 +++++++++++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi |  8 ++++++++
 10 files changed, 33 insertions(+), 27 deletions(-)

-- 
2.11.0
