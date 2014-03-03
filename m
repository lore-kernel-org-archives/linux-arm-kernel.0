From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Mar 2014 09:55:03 +0000 (GMT)
Subject: [GIT PULL 4/6] Samsung clk-exynos updates for v3.15
Message-ID: <11757345.260501393840501095.JavaMail.weblogic@epml16>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d726ca2d3316743841063a98fb113ff22a236e63:

  ARM: dts: Add vmmc-supply to MMC on arndale-octa board (2014-02-24 08:56:46 +0900)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git tags/exynos-clk

for you to fetch changes up to 86feafebbec2b510daf36ffbdbe10228ed890b00:

  ARM: dts: use macros in clock bindings for exynos5440 (2014-02-26 09:53:31 +0900)

----------------------------------------------------------------
Samsung exynos clock related DT updates for v3.15

- use macros instead of hard coded numbers for clock bindings

NOTE: this is based on v3.15-next/dt-samsung

----------------------------------------------------------------
Andrzej Hajda (4):
      ARM: dts: use macros in clock bindings for exynos4
      ARM: dts: use macros in clock bindings for exynos5250
      ARM: dts: use macros in clock bindings for exynos5420
      ARM: dts: use macros in clock bindings for exynos5440

 .../devicetree/bindings/clock/exynos4-clock.txt    |  259 +-------------------
 .../devicetree/bindings/clock/exynos5250-clock.txt |  163 +-----------
 .../devicetree/bindings/clock/exynos5420-clock.txt |  184 +-------------
 .../devicetree/bindings/clock/exynos5440-clock.txt |   45 +---
 arch/arm/boot/dts/exynos4.dtsi                     |   73 +++---
 arch/arm/boot/dts/exynos4210.dtsi                  |    9 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |   34 ++-
 arch/arm/boot/dts/exynos5250.dtsi                  |  105 ++++----
 arch/arm/boot/dts/exynos5420.dtsi                  |   95 +++----
 arch/arm/boot/dts/exynos5440.dtsi                  |   33 +--
 10 files changed, 207 insertions(+), 793 deletions(-)
