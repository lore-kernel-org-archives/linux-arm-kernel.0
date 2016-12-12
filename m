From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Dec 2016 10:11:29 +0100
Subject: [PATCH renesas/devel 00/13] ARM,
 arm64: dts: Use R-Car fallback bindings for i2c/iic nodes
Message-ID: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series makes use of newly added R-Car fallback bindings in
i2c and iic nodes of the DTs for SoCs where the drivers in question are
already used.

This should have no run-time effect at this time as the current
driver implementations use the same initialisation squeuences for
SoC-specific and R-Car fallback bindings for all the cases covered by
this patch-set.

Based on renesas-devel-20161212-v4.9

Simon Horman (13):
  ARM: dts: r8a7779: Use R-Car Gen 1 fallback binding for i2c nodes
  ARM: dts: r8a7778: Use R-Car Gen 1 fallback binding for i2c nodes
  ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for i2c nodes
  ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for i2c nodes
  ARM: dts: r8a7792: Use R-Car Gen 2 fallback binding for i2c nodes
  ARM: dts: r8a7793: Use R-Car Gen 2 fallback binding for i2c nodes
  ARM: dts: r8a7794: Use R-Car Gen 2 fallback binding for i2c nodes
  arm64: dts: r8a7795: Use R-Car Gen 3 fallback binding for i2c nodes
  arm64: dts: r8a7796: Use R-Car Gen 3 fallback binding for i2c nodes
  ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for i2c nodes
  ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for i2c nodes
  ARM: dts: r8a7793: Use R-Car Gen 2 fallback binding for i2c nodes
  ARM: dts: r8a7794: Use R-Car Gen 2 fallback binding for i2c nodes

 arch/arm/boot/dts/r8a7778.dtsi           |  8 ++++----
 arch/arm/boot/dts/r8a7779.dtsi           |  8 ++++----
 arch/arm/boot/dts/r8a7790.dtsi           | 20 ++++++++++++--------
 arch/arm/boot/dts/r8a7791.dtsi           | 21 ++++++++++++---------
 arch/arm/boot/dts/r8a7792.dtsi           | 18 ++++++++++++------
 arch/arm/boot/dts/r8a7793.dtsi           | 21 ++++++++++++---------
 arch/arm/boot/dts/r8a7794.dtsi           | 18 ++++++++++--------
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 21 ++++++++++++++-------
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 21 ++++++++++++++-------
 9 files changed, 94 insertions(+), 62 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
