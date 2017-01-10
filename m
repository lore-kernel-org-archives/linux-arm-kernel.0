From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 10 Jan 2017 14:38:29 -0300
Subject: [PATCH v2 0/3] arm64: dts: exynos: Fix DTC warnings for Exynos boards
Message-ID: <1484069912-6534-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

This trivial series contains fixes for DTC warnings caused by mismatches
between unit names and reg properties in device tree nodes.

The patches shouldn't cause a functional change but have been just build
tested. I compared the generated DTB though to make sure that only these
nodes changed.

Best regards,
Javier

Changes since v1:
  - Fix subject line since I forgot the "exynos" prefix.


Javier Martinez Canillas (3):
  arm64: dts: exynos: Add missing unit name to Exynos7 SoC node
  arm64: dts: exynos: Add missing unit name to Exynos5433 SoC node
  arm64: dts: exynos: Remove unneeded unit names in Exynos5433 nodes

 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 8 ++++----
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4
