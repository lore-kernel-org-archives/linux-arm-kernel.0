From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 23:41:55 +0200
Subject: [PATCH 0/7] ARM: dts: exynos Use human-friendly symbols for interrupt
 properties
Message-ID: <1474062122-22720-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Based on top of [1]. Shouldn't make any difference - tested with dtx_diff.

Best regards,
Krzysztof

[1] http://www.spinics.net/lists/arm-kernel/msg532489.html


Krzysztof Kozlowski (7):
  arm64: dts: exynos: Use human-friendly symbols for interrupt
    properties in exynos7
  ARM: dts: exynos: Use human-friendly symbols for interrupt properties
    in exynos3250
  ARM: dts: exynos: Use human-friendly symbols for interrupt properties
    in exynos4
  ARM: dts: exynos: Use human-friendly symbols for interrupt properties
    in exynos5
  ARM: dts: exynos: Use human-friendly symbols for interrupt properties
    in exynos4415
  ARM: dts: exynos: Use human-friendly symbols for interrupt properties
    in exynos5260
  ARM: dts: exynos: Use human-friendly symbols for interrupt properties
    in exynos5440

 arch/arm/boot/dts/exynos3250-pinctrl.dtsi       |  32 +++----
 arch/arm/boot/dts/exynos3250.dtsi               | 112 ++++++++++++------------
 arch/arm/boot/dts/exynos4.dtsi                  |  99 ++++++++++-----------
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi       |  32 +++----
 arch/arm/boot/dts/exynos4210.dtsi               |  40 ++++-----
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi       |  32 +++----
 arch/arm/boot/dts/exynos4415.dtsi               | 108 ++++++++++++-----------
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi       |  32 +++----
 arch/arm/boot/dts/exynos4x12.dtsi               |  60 ++++++-------
 arch/arm/boot/dts/exynos5.dtsi                  |   4 +-
 arch/arm/boot/dts/exynos5250.dtsi               |  76 ++++++++--------
 arch/arm/boot/dts/exynos5260.dtsi               |  50 ++++++-----
 arch/arm/boot/dts/exynos5410.dtsi               |  16 ++--
 arch/arm/boot/dts/exynos5440.dtsi               |  80 ++++++++---------
 arch/arm/boot/dts/exynos54xx.dtsi               |  18 ++--
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |  32 +++----
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |  70 +++++++--------
 17 files changed, 452 insertions(+), 441 deletions(-)

-- 
2.7.4
