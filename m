From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 Apr 2016 12:01:20 +0200
Subject: [GIT PULL 3/5] arm64: dts: exynos: DT for v4.7
In-Reply-To: <1460541682-32417-1-git-send-email-k.kozlowski@samsung.com>
References: <1460541682-32417-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1460541682-32417-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

arm64 Device Tree changes.

Best regards,
Krzysztof


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.7

for you to fetch changes up to afa05e55a047f8aa7c865dde5353d96d136aeab2:

  arm64: dts: Add nodes for pdma0 and pdma1 for exynos7 (2016-04-13 11:31:44 +0200)

----------------------------------------------------------------
Samsung Device Tree ARM64 updates and improvements for v4.7:
1. Add PL330 DMA controller and Thermal Management Unit to Exynos 7.

----------------------------------------------------------------
Alim Akhtar (2):
      arm64: dts: exynos: Add TMU node for exynos7
      arm64: dts: Add nodes for pdma0 and pdma1 for exynos7

 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   | 25 ++++++++++
 .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi | 54 ++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            | 49 ++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
