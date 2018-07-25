From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jul 2018 17:55:14 +0200
Subject: [PATCH 0/3] clk/dts: s2mps11: Fix matching as module
Message-ID: <20180725155517.4872-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The DTS patches depend on 1st clock patch.  I will take them through
samsung-soc tree in next release.

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  clk: s2mps11: Fix matching when built as module and DT node contains
    compatible
  ARM: dts: exynos: Add compatible for s2mps11 clocks node on Exynos542x
  ARM: dts: exynos: Add compatible for s5m8767 clocks node on Itop Core

 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi |  1 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |  1 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |  1 +
 drivers/clk/clk-s2mps11.c                       | 30 +++++++++++++++++++++++++
 5 files changed, 34 insertions(+)

-- 
2.14.1
