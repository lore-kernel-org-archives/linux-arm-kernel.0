From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Oct 2017 14:33:01 +0200
Subject: [PATCH v3 00/10] arm64: dts: renesas: Use R-Car GPIO Gen[123]
 fallback compat strings
Message-ID: <20171013123311.15278-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen 1, 2 and 3 fallback compat strings in peace
of now deprecated non-generation specific R-Car GPIO fallback compat string
in the DT of Renesas ARM and arm64 based SoCs.

As notied in the changelogs for the r8a777[89] changes, this introduces
an incompatibility with pre-v4.14 kernels used with new DTBs. There is
no run-time effect for other SoCs updated by this changeset.

Based on renesas-devel-20171013-v4.14-rc4

Changes since v2:
* Consistently use and refer to gen1 rather than gen2 binding
  in patches for gen1 SoCs

Changes since v1:
* Accumulate review tags
* Note run-time effect for r8a777[89] SoCs

Simon Horman (10):
  ARM: dts: r8a7778: Use R-Car GPIO Gen1 fallback compat string
  ARM: dts: r8a7779: Use R-Car GPIO Gen1 fallback compat string
  ARM: dts: r8a7743: Use R-Car GPIO Gen2 fallback compat string
  ARM: dts: r8a7790: Use R-Car GPIO Gen2 fallback compat string
  ARM: dts: r8a7791: Use R-Car GPIO Gen2 fallback compat string
  ARM: dts: r8a7792: Use R-Car GPIO Gen2 fallback compat string
  ARM: dts: r8a7793: Use R-Car GPIO Gen2 fallback compat string
  ARM: dts: r8a7794: Use R-Car GPIO Gen2 fallback compat string
  arm64: dts: r8a7795: Use R-Car GPIO Gen3 fallback compat string
  arm64: dts: r8a7796: Use R-Car GPIO Gen3 fallback compat string

 arch/arm/boot/dts/r8a7743.dtsi           | 16 ++++++++--------
 arch/arm/boot/dts/r8a7778.dtsi           | 10 +++++-----
 arch/arm/boot/dts/r8a7779.dtsi           | 14 +++++++-------
 arch/arm/boot/dts/r8a7790.dtsi           | 12 ++++++------
 arch/arm/boot/dts/r8a7791.dtsi           | 16 ++++++++--------
 arch/arm/boot/dts/r8a7792.dtsi           | 24 ++++++++++++------------
 arch/arm/boot/dts/r8a7793.dtsi           | 16 ++++++++--------
 arch/arm/boot/dts/r8a7794.dtsi           | 14 +++++++-------
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 16 ++++++++--------
 10 files changed, 77 insertions(+), 77 deletions(-)

-- 
2.11.0
