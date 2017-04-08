From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  8 Apr 2017 16:10:03 +0200
Subject: [GIT PULL 4/5] arm64: dts: exynos: DTS for v4.12
In-Reply-To: <20170408141004.386-1-krzk@kernel.org>
References: <20170408141004.386-1-krzk@kernel.org>
Message-ID: <20170408141004.386-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.12

for you to fetch changes up to e3c07546747cdec07ff15c984bc6cebc9c9f788c:

  arm64: dts: exynos: Add the burst and esc clock frequency properties to DSI node (2017-03-08 08:55:39 +0200)

----------------------------------------------------------------
Samsung DeviceTree ARM64 update for v4.12:
1. Add IR, touchscreen and panel to TM2/TM2E boards.
2. Add proper clock frequency properties to DSI nodes.

----------------------------------------------------------------
Andi Shyti (2):
      arm64: dts: exynos: Enable ir-spi in the TM2 and TM2E boards
      arm64: dts: exynos: Add stmfts touchscreen node for TM2 and TM2E

Hoegeun Kwon (1):
      arm64: dts: exynos: Add the burst and esc clock frequency properties to DSI node

Hyungwon Hwang (1):
      arm64: dts: exynos: Add support for S6E3HA2 panel device on TM2 board

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 43 +++++++++++++++++++++-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 17 +++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |  7 ++++
 3 files changed, 65 insertions(+), 2 deletions(-)
