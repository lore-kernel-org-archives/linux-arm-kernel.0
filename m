From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Jul 2016 15:48:24 -0700
Subject: [GIT PULL] Amlogic SoC updates for v4.8 (#2)
Message-ID: <m28txeqt6v.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the 2nd round of SoC changes for Amlogic.

Kevin


The following changes since commit bf56c7762df2ef60512eb58c5f4525d173a4da22:

  ARM64: Kconfig: Select the Amlogic Meson pin controller driver (2016-06-01 10:55:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-soc-2

for you to fetch changes up to 59f910d8fbd9d7c2957ad4df642dc262fbfdcd59:

  arm64: amlogic: select gxbb clk driver (2016-06-23 15:22:37 -0700)

----------------------------------------------------------------
Amlogic SoC updates:
- Kconfig updates for new GXBB clock driver

----------------------------------------------------------------
Michael Turquette (2):
      arm: meson: explicitly select clk drivers
      arm64: amlogic: select gxbb clk driver

 arch/arm/mach-meson/Kconfig  | 3 +++
 arch/arm64/Kconfig.platforms | 2 ++
 2 files changed, 5 insertions(+)
