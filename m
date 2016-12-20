From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Dec 2016 11:32:35 +0100
Subject: [PATCH renesas/devel 0/4] ARM,
 arm64: dts: Use R-Car fallback bindings for msiof nodes
Message-ID: <1482229959-25584-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series makes use of newly added R-Car fallback bindings in msiof
nodes of the DTs for SoCs where the drivers in question are already used.

This should have no run-time effect at this time as the current driver
implementations use the same initialisation sequences for SoC-specific and
R-Car fallback bindings for all the cases covered by this patch-set.

Based on renesas-devel-20161212-v4.9

Simon Horman (4):
  arm64: dts: r8a7796: Use R-Car Gen 3 fallback binding for msiof nodes
  ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for msiof nodes
  ARM: dts: r8a7792: Use R-Car Gen 2 fallback binding for msiof nodes
  ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for msiof nodes

 arch/arm/boot/dts/r8a7790.dtsi           | 12 ++++++++----
 arch/arm/boot/dts/r8a7791.dtsi           |  9 ++++++---
 arch/arm/boot/dts/r8a7792.dtsi           |  6 ++++--
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 12 ++++++++----
 4 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
