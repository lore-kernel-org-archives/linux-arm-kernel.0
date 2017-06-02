From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  2 Jun 2017 20:13:44 +0200
Subject: [PATCH 0/2] ARM: dts: exynos: Use human-friendly symbols for
 interrupt flags
Message-ID: <20170602181346.32166-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Tested with comparing decompiled DTBs (dtx_diff). No differences.

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  ARM: dts: exynos: Use human-friendly symbols for interrupt flags in
    board sources
  ARM: dts: exynos: Use human-friendly symbols for GIC interrupt
    properties

 arch/arm/boot/dts/exynos3250-monk.dts             |  6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts           |  6 +-
 arch/arm/boot/dts/exynos4210-origen.dts           |  2 +-
 arch/arm/boot/dts/exynos4210-trats.dts            |  4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi   |  6 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts          |  2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts           |  8 +--
 arch/arm/boot/dts/exynos5.dtsi                    | 84 +++++++++++------------
 arch/arm/boot/dts/exynos5250.dtsi                 |  8 +--
 arch/arm/boot/dts/exynos5420-peach-pit.dts        |  4 +-
 arch/arm/boot/dts/exynos5420.dtsi                 | 76 ++++++++++----------
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi |  2 +-
 arch/arm/boot/dts/exynos5440.dtsi                 |  2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts         |  4 +-
 14 files changed, 107 insertions(+), 107 deletions(-)

-- 
2.9.3
