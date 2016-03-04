From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  4 Mar 2016 15:57:00 +0100
Subject: [GIT PULL 2/3] ARM: tegra: Devicetree changes for v4.6-rc1
In-Reply-To: <1457103421-26006-1-git-send-email-thierry.reding@gmail.com>
References: <1457103421-26006-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1457103421-26006-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.6-arm

for you to fetch changes up to 2bd451d6f5a47eb79feddfa4af827e3b63ed99e9:

  ARM: tegra: Replace legacy *,wakeup property with wakeup-source (2016-02-16 11:32:40 +0100)

----------------------------------------------------------------
ARM: tegra: Devicetree changes for v4.6-rc1

These patches clean up some of the 32-bit ARM device tree files and
remove redundant Kconfig dependencies.

----------------------------------------------------------------
Maarten Lankhorst (1):
      ARM: tegra: Enable watchdog support for Tegra114 and Tegra124

Masahiro Yamada (1):
      ARM: tegra: Remove redundant ARM_L1_CACHE_SHIFT_6 select

Ralf Ramsauer (2):
      ARM: tegra: Fix copy/paste typo in several DTS includes
      ARM: tegra: Add high speed UARTs to Jetson TK1 device tree

Sudeep Holla (1):
      ARM: tegra: Replace legacy *,wakeup property with wakeup-source

 arch/arm/boot/dts/tegra114-dalmore.dts        |  2 +-
 arch/arm/boot/dts/tegra114-roth.dts           |  2 +-
 arch/arm/boot/dts/tegra114-tn7.dts            |  2 +-
 arch/arm/boot/dts/tegra114.dtsi               |  4 ++--
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     | 28 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/tegra124-nyan.dtsi          |  4 ++--
 arch/arm/boot/dts/tegra124-venice2.dts        |  2 +-
 arch/arm/boot/dts/tegra124.dtsi               |  4 ++--
 arch/arm/boot/dts/tegra20-harmony.dts         |  2 +-
 arch/arm/boot/dts/tegra20-paz00.dts           |  2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts        |  4 ++--
 arch/arm/boot/dts/tegra20-trimslice.dts       |  2 +-
 arch/arm/boot/dts/tegra20-ventana.dts         |  2 +-
 arch/arm/boot/dts/tegra20-whistler.dts        |  2 +-
 arch/arm/boot/dts/tegra20.dtsi                |  2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts     |  2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi         |  2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  2 +-
 arch/arm/boot/dts/tegra30.dtsi                |  2 +-
 drivers/soc/tegra/Kconfig                     |  2 --
 20 files changed, 49 insertions(+), 25 deletions(-)
