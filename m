From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 10 Oct 2018 20:25:56 +0200
Subject: [GIT PULL 2/4] arm64: dts: exynos: Stuff for v4.20
In-Reply-To: <20181010182558.7034-1-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org>
Message-ID: <20181010182558.7034-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.20

for you to fetch changes up to 2352ae1306974528d11fb9c7dbf2cf91e0dd2c31:

  arm64: ARM: dts: exynos: Remove double SD card detect pin inversion on TM2 (2018-09-24 19:30:54 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.20

1. Use graph between USB-PHY and MUIC.
2. Cleanup of SD card detect pin level.

----------------------------------------------------------------
Andrzej Hajda (1):
      arm64: dts: exynos: Add OF graph between USB-PHY and MUIC

Krzysztof Kozlowski (1):
      arm64: ARM: dts: exynos: Remove double SD card detect pin inversion on TM2

 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)
