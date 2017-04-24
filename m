From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 24 Apr 2017 20:23:35 +0200
Subject: [GIT PULL 2/2] arm64 dts: exynos: Last round for v4.12, fixed
In-Reply-To: <20170421164050.7404-2-krzk@kernel.org>
References: <20170421164050.7404-2-krzk@kernel.org>
Message-ID: <20170424182335.5019-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

Fixed previous pull because of my doubled Signed-off-by in one comit.

Best regards,
Krzysztof


The following changes since commit e3c07546747cdec07ff15c984bc6cebc9c9f788c:

  arm64: dts: exynos: Add the burst and esc clock frequency properties to DSI node (2017-03-08 08:55:39 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.12-3

for you to fetch changes up to 684c581f10f5e21976d9dcd85a190f37ddc843dd:

  arm64: dts: exynos: Use - instead of @ for DT OPP entries (2017-04-24 20:19:32 +0200)

----------------------------------------------------------------
Second update of Samsung DeviceTree ARM64 for v4.12:
 - Fix DTC warnings in Exynos ARM64 Device Tree sources.
 - Add panel node to TM2E board.

----------------------------------------------------------------
Hoegeun Kwon (1):
      arm64: dts: exynos: Add support for s6e3hf2 panel device on TM2e board

Viresh Kumar (1):
      arm64: dts: exynos: Use - instead of @ for DT OPP entries

 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi | 48 ++++++++++++-------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 11 ++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi     | 50 +++++++++++++-------------
 3 files changed, 60 insertions(+), 49 deletions(-)
