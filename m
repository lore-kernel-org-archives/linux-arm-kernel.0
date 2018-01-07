From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  7 Jan 2018 12:36:24 +0100
Subject: [GIT PULL 2/4] arm64: dts: exynos: Stuff for v4.16, 2nd round
In-Reply-To: <20180107113625.15488-1-krzk@kernel.org>
References: <20180107113625.15488-1-krzk@kernel.org>
Message-ID: <20180107113625.15488-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 3808354701090723b53c73afaccfcafdeb8a5bfe:

  arm64: dts: exynos: Increase bus frequency for MHL chip (2017-12-04 17:51:10 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.16-2

for you to fetch changes up to 45fef752126603d591754befa63d0a800492eb6c:

  arm64: dts: exynos: Add SPDX license identifiers (2018-01-03 18:16:35 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.16, part 2

1. Fix DTC warnings around unit addresses.
2. Add SPDX license identifiers.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      arm64: dts: exynos: Use lower case hex addresses in node unit addresses
      arm64: dts: exynos: Fix typo in MSCL clock controller unit address of Exynos5433
      arm64: dts: exynos: Add SPDX license identifiers

 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi            |  5 +----
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi        |  5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi     |  5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts             |  5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts            |  5 +----
 .../boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi   |  5 +----
 .../arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi |  5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi            |  5 +----
 arch/arm64/boot/dts/exynos/exynos5433.dtsi                | 15 ++++++---------
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts           |  7 ++-----
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi           |  7 ++-----
 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |  6 +-----
 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi       |  6 +-----
 arch/arm64/boot/dts/exynos/exynos7.dtsi                   |  9 +++------
 14 files changed, 23 insertions(+), 67 deletions(-)
