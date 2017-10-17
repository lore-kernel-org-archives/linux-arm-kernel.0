From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 08:09:48 +0200
Subject: [PATCH 00/11] arm64: dts: renesas: Use R-Car SDHI Gen[123] fallback
 compat strings
Message-ID: <20171017060959.16702-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently posted R-Car SDHI Gen 1, 2 and 3 fallback compat strings
in the DT of Renesas ARM and arm64 based SoCs.

Based on renesas-devel-20171016-v4.14-rc5

Has a binding documentation but no run-time dependency on
"[PATCH v3 0/3] mmc: renesas_sdhi: add R-Car Gen[123] fallback
compatibility strings"

Simon Horman (11):
  arm64: dts: renesas: r8a7795: Use R-Car SDHI Gen3 fallback compat
    string
  arm64: dts: renesas: r8a7796: Use R-Car SDHI Gen3 fallback compat
    string
  ARM: dts: r8a7743: Use R-Car SDHI Gen2 fallback compat string
  ARM: dts: r8a7745: Use R-Car SDHI Gen2 fallback compat string
  ARM: dts: r8a7778: Use R-Car SDHI Gen1 fallback compat string
  ARM: dts: r8a7779: Use R-Car SDHI Gen1 fallback compat string
  ARM: dts: r8a7790: Use R-Car SDHI Gen2 fallback compat string
  ARM: dts: r8a7791: Use R-Car SDHI Gen2 fallback compat string
  ARM: dts: r8a7792: Use R-Car SDHI Gen2 fallback compat string
  ARM: dts: r8a7793: Use R-Car SDHI Gen2 fallback compat string
  ARM: dts: r8a7794: Use R-Car SDHI Gen2 fallback compat string

 arch/arm/boot/dts/r8a7743.dtsi           |  9 ++++++---
 arch/arm/boot/dts/r8a7745.dtsi           |  9 ++++++---
 arch/arm/boot/dts/r8a7778.dtsi           |  9 ++++++---
 arch/arm/boot/dts/r8a7779.dtsi           | 12 ++++++++----
 arch/arm/boot/dts/r8a7790.dtsi           | 12 ++++++++----
 arch/arm/boot/dts/r8a7791.dtsi           |  9 ++++++---
 arch/arm/boot/dts/r8a7792.dtsi           |  3 ++-
 arch/arm/boot/dts/r8a7793.dtsi           |  9 ++++++---
 arch/arm/boot/dts/r8a7794.dtsi           |  9 ++++++---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++++----
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 12 ++++++++----
 11 files changed, 70 insertions(+), 35 deletions(-)

-- 
2.11.0
