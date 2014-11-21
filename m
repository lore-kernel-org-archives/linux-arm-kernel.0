From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 21 Nov 2014 23:16:18 +0900
Subject: [GIT PULL 4/5] Samsung 2nd round of DT updates for v3.19
Message-ID: <546F4932.2070702@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e540920cf21c2764047b8a6ddaeaa0683624e46e:

  ARM: dts: add CPU nodes for Exynos4 SoCs (2014-10-21 00:12:42 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-2

for you to fetch changes up to a427d15062ac46a00a22d2f0b9d05093c18ff2f1:

  ARM: dts: Add micro SD card SDHCI node for exynos4412-trats
(2014-11-07 08:28:24 +0900)

----------------------------------------------------------------
Samsung 2nd DT updates for v3.19

- add micro SD card SDHCI node for exynos4412-trats
- add exynos4415 DT
- add exynos3250-rinato DT and sleep mode support

Note: based on previous tags/samsung-dt for v3.19

----------------------------------------------------------------
Chanwoo Choi (4):
      ARM: dts: Add board dts file for exynos3250-rinato
      ARM: dts: Add sleep mode pin configuration for exynos3250-rinato
      ARM: dts: Add sleep mode of regulator for exynos3250-rinato
      ARM: dts: Add dts files for exynos4415 SoC

Krzysztof Kozlowski (1):
      ARM: dts: Add micro SD card SDHCI node for exynos4412-trats

 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  16 +
 arch/arm/boot/dts/exynos3250-rinato.dts   | 686
++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts   |  10 +
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi | 573 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4415.dtsi         | 604 ++++++++++++++++++++++++++
 6 files changed, 1891 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/exynos3250-rinato.dts
 create mode 100644 arch/arm/boot/dts/exynos4415-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4415.dtsi
