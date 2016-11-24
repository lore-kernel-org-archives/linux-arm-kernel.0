From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 24 Nov 2016 08:08:29 +0200
Subject: [GIT PULL 3/3] arm64: dts: exynos: DT for v4.10, second round
In-Reply-To: <1479967709-6619-1-git-send-email-krzk@kernel.org>
References: <1479967709-6619-1-git-send-email-krzk@kernel.org>
Message-ID: <1479967709-6619-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull/tag.

Best regards,
Krzysztof


The following changes since commit 8ac46fc57df82efbc19194dddd335b6c7a960c31:

  arm64: dts: exynos: Add dts file for Exynos5433-based TM2E board (2016-11-03 22:19:57 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.10-2

for you to fetch changes up to 2a4c744fcb1549023478e4b9e724d268d8202158:

  arm64: dts: exynos: Enable HS400 mode for eMMC for TM2 (2016-11-23 19:27:56 +0200)

----------------------------------------------------------------
Samsung DeviceTree arm64 second update for v4.10:
1. Add Performance Monitor Unit to Exynos7.
2. Add MFC, JPEG and Gscaler to Exynos5433 based TM2 board.
3. Cleanups and fixes for recently added TM2 and TM2E boards.

----------------------------------------------------------------
Alim Akhtar (1):
      arm64: dts: Add ARM PMU node for exynos7

Jaehoon Chung (2):
      arm64: dts: exynos: Add the mshc_2 node for supporting T-Flash
      arm64: dts: exynos: Enable HS400 mode for eMMC for TM2

Marek Szyprowski (8):
      arm64: dts: exynos: Fix IRQ type flags for Exynos5433 SoC
      arm64: dts: exynos: Fix FSYS CMU parent clocks in Exynos5433 SoC
      arm64: dts: exynos: Add missing parent clocks to audio block in Exynos5433 SoC
      arm64: dts: exynos: Move FSYS CMU configuration from Exynos5433 dtsi to TM2 dts
      arm64: dts: exynos: TM2 - remove unused UART3 and set clocks directly on CMU
      arm64: dts: exynos: TM2 - add support for GScaler devices
      arm64: dts: exynos: TM2 - add support for JPEG codec device
      arm64: dts: exynos: TM2 - add support for MFC video codec device

Sylwester Nawrocki (1):
      arm64: dts: exynos: Assign parent clock of the clkout clock for TM2 board

 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  22 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  85 +++++-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 286 ++++++++++++++-------
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  18 +-
 4 files changed, 306 insertions(+), 105 deletions(-)
