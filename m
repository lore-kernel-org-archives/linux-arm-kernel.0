From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 20 Dec 2017 18:36:43 +0100
Subject: [GIT PULL 2/3] arm64: dts: exynos: DTS for v4.16
In-Reply-To: <20171220173643.5840-1-krzk@kernel.org>
References: <20171220173643.5840-1-krzk@kernel.org>
Message-ID: <20171220173643.5840-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.16

for you to fetch changes up to 3808354701090723b53c73afaccfcafdeb8a5bfe:

  arm64: dts: exynos: Increase bus frequency for MHL chip (2017-12-04 17:51:10 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.16

1. Add CPU perf counters to Exynos5433.
2. Add missing power domains to Exynos5433.
3. Add NFC chip to Exynos5433 TM2/TM2E.
4. Fix obscure bugs on I2C transfers to MHL chip on TM2/TM2E.

----------------------------------------------------------------
Andrzej Hajda (1):
      arm64: dts: exynos: Increase bus frequency for MHL chip

Marek Szyprowski (8):
      arm64: dts: exynos: Add CPU performance counters to Exynos5433 boards
      arm64: dts: exynos: Add support for S3FWRN5 NFC chip to TM2(e) boards
      arm64: dts: exynos: Add GSCL power domain to Exynos 5433 SoC
      arm64: dts: exynos: Add DISP power domain to Exynos 5433 SoC
      arm64: dts: exynos: Add MSCL power domain to Exynos 5433 SoC
      arm64: dts: exynos: Add MFC power domain to Exynos 5433 SoC
      arm64: dts: exynos: Add AUD power domain to Exynos5433 SoC
      arm64: dts: exynos: Add remaining power domains to Exynos5433 SoC

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  14 +++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 132 +++++++++++++++++++++
 2 files changed, 146 insertions(+)
