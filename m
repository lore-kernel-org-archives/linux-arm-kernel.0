From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 04 Nov 2013 10:55:58 +0900
Subject: [PATCHv3 0/3] ARM: dts: exynos: Add missing dt data to bring up kernel
 featurea
Message-ID: <1383530161-24080-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add missing dt data to bring up kernel feature
- GPS_ALIVE power domain
- PMU
- Clock data for Multi core timer

Changes since v2:
- Delete MAUDIO power domain

Changes since v1:
- Fix wrong address of GPS_ALIVE power domain

Chanwoo Choi (2):
  ARM: dts: exynos4212: Add PMU dt data for pmu-irq
  ARM: dts: exynos4x12: Add gps_alive power domain for exynos4x12

Marek Szyprowski (1):
  ARM: dts: exynos4212: Add missing clock for multi core timer

 arch/arm/boot/dts/exynos4212.dtsi | 8 ++++++++
 arch/arm/boot/dts/exynos4x12.dtsi | 5 +++++
 2 files changed, 13 insertions(+)

-- 
1.8.0
