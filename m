From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  8 Nov 2016 20:26:29 +0200
Subject: [GIT PULL 2/3] ARM64: dts: exynos: DT for v4.10
In-Reply-To: <1478629589-7520-1-git-send-email-krzk@kernel.org>
References: <1478629589-7520-1-git-send-email-krzk@kernel.org>
Message-ID: <1478629589-7520-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Exynos5433 + two boards using it. Mobile boards! :)

I am really happy to push it. I know that it has been a lot of effort
in Samsung to mainline this.

Best regards,
Krzysztof


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.10

for you to fetch changes up to 8ac46fc57df82efbc19194dddd335b6c7a960c31:

  arm64: dts: exynos: Add dts file for Exynos5433-based TM2E board (2016-11-03 22:19:57 +0200)

----------------------------------------------------------------
Finally, I am really pleased to announce adding support for Exynos5433 ARMv8
SoC along with two boards.  A lot of Samsung people contributed into this
but the final work and commits were done by Chanwoo Choi.

This means that for v4.10 we got:
1. Exynos5433 DTSI.
2. Two boards: TM2 and TM2E.  These are (almost fully) working mobile phones.

----------------------------------------------------------------
Chanwoo Choi (3):
      arm64: dts: exynos: Add dtsi files for Samsung Exynos5433 64bit SoC
      arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board
      arm64: dts: exynos: Add dts file for Exynos5433-based TM2E board

 .../bindings/arm/samsung/samsung-boards.txt        |    2 +
 arch/arm64/boot/dts/exynos/Makefile                |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  794 ++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  974 ++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   41 +
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |   23 +
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |   22 +
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     |  296 +++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 1356 ++++++++++++++++++++
 9 files changed, 3512 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi
