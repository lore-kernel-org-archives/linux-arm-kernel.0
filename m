From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 11 Jul 2017 14:56:46 +0200
Subject: [PATCH 0/3] ARM: dts: r8a779[014]: Use R-Car Gen 2 fallback binding
 for vin nodes
Message-ID: <1499777809-27492-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use R-Car Gen 2 fallback binding for vind nodes in DT for r8a779[014] SoCs.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a779[014] and the
fallback binding for R-Car Gen 2

This is consistent with existing compat string usage in vin nodes for the
r8a779[23] SoCs.

Based on renesas-devel-20170711-v4.12

Simon Horman (3):
  ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for vin nodes
  ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for vin nodes
  ARM: dts: r8a7794: Use R-Car Gen 2 fallback binding for vin nodes

 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 arch/arm/boot/dts/r8a7791.dtsi | 6 +++---
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.1.4
