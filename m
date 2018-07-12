From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 12 Jul 2018 18:46:41 +0200
Subject: [GIT PULL 2/3] arm64: dts: exynos: Pull for v4.19
In-Reply-To: <20180712164641.19925-1-krzk@kernel.org>
References: <20180712164641.19925-1-krzk@kernel.org>
Message-ID: <20180712164641.19925-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Rebased on v4.18-rc2.

Best regards,
Krzysztof


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.19

for you to fetch changes up to 17aa1530f1ff89ca4e21765e5f4d9e6bcd464eb2:

  arm64: dts: exynos: Remove leading 0x from unit addresses in Exynos5433 (2018-06-25 18:38:49 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.19

Cleanup from old properties and code-style warnings.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      arm64: dts: exynos: Remove no longer needed samsung thermal properties

Krzysztof Kozlowski (1):
      arm64: dts: exynos: Remove leading 0x from unit addresses in Exynos5433

 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  | 20 --------------------
 .../boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi | 19 -------------------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi          | 14 +++++++-------
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi    | 21 ---------------------
 arch/arm64/boot/dts/exynos/exynos7.dtsi             |  2 +-
 5 files changed, 8 insertions(+), 68 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
