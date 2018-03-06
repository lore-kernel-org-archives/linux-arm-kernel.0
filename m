From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  6 Mar 2018 19:01:23 +0100
Subject: [GIT PULL 4/4] arm64: dts: exynos: DTS for v4.17
In-Reply-To: <20180306180124.8987-1-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org>
Message-ID: <20180306180124.8987-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.17

for you to fetch changes up to 6ca620371ab2dab89a7645fc363453d2e26c992e:

  arm64: dts: exynos: add OF graph between MHL and USB connector (2018-03-06 17:48:07 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.17

1. Add support for HDMI audio on Exynos 5433 TM2/TM2E boards.
2. Add support for USB-MHL connector on Exynos 5433 TM2/TM2E boards.

----------------------------------------------------------------
Andrzej Hajda (2):
      arm64: dts: exynos: add micro-USB connector node to TM2 platforms
      arm64: dts: exynos: add OF graph between MHL and USB connector

Sylwester Nawrocki (3):
      ARM: dts: exynos: Add I2S1 device node to exynos5433
      ARM: dts: exynos: Update I2S0 device node in exynos5433
      ARM: dts: exynos: Add support for HDMI audio on Exynos 5433 TM2 board

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 90 ++++++++++++++++++++--
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 24 +++++-
 2 files changed, 106 insertions(+), 8 deletions(-)
