From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Oct 2013 14:45:33 +0900
Subject: [PATCHv2 0/3] ARM: dts: exynos: Add missing dt data to bring up kernel
 feature
Message-ID: <1381383936-2627-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add missing dt data to bring up kernel feature
- MAUDIO/GPS_ALIVE power domain
- PMU
- Clock data for Multi core timer

Changes since v1:
- Fix wrong address of GPS_ALIVE power domain

Chanwoo Choi (2):
  ARM: dts: exynos4212: Add PMU dt data for pmu-irq
  ARM: dts: exynos4x12: Add maudio/gps_alive power domain for exynos4x12

Marek Szyprowski (1):
  ARM: dts: exynos4212: Add missing clock for multi core timer

 arch/arm/boot/dts/exynos4212.dtsi |  8 ++++++++
 arch/arm/boot/dts/exynos4x12.dtsi | 10 ++++++++++
 2 files changed, 18 insertions(+)

-- 
1.8.0
