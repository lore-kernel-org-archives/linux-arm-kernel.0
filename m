From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Wed, 28 Aug 2013 18:12:46 +0530
Subject: [PATCH 0/2] Exynos5 device tree fixes
Message-ID: <1377693768-16777-1-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes two problem with MCT node in Exynos5 platforms.
1. In Exynos5250 it fixes the number of interrupt-cells.
2. Removes invalid properties in MCT node for Exynos5420 and Exynos5250.

Chander Kashyap (2):
  ARM: DT: Exynos5250: fix number of interrupt-cells in mct node
  DTS: Exynos5: Remove invalid MCT properties

 arch/arm/boot/dts/exynos5250.dtsi |   19 ++++++++-----------
 arch/arm/boot/dts/exynos5420.dtsi |    2 --
 2 files changed, 8 insertions(+), 13 deletions(-)

-- 
1.7.9.5
