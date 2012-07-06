From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  6 Jul 2012 10:46:46 -0600
Subject: [GIT PULL 5/7] ARM: tegra: for-3.6/dt branch
In-Reply-To: <1341593208-17914-1-git-send-email-swarren@wwwdotorg.org>
References: <1341593208-17914-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1341593208-17914-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains changes to Tegra device tree files, and related Kconfig
and Makefile changes. Highlights are:

* New support for the Whistler board.
* Use of the I2C pinctrl-based bus mux on Seaboard/Springbank.

The branch is based on Tegra's for-3.6/boards branch from a previous pull
request.

This branch is NOT included in a later pull request.

----------------------------------------------------------------

The following changes since commit 2553dcc6e603e3833990bd3a29bee98d1dbdf251:

  ARM: tegra: use of_default_bus_match_table

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git for-3.6/dt

for you to fetch changes up to d42d7ae61861ef73e1790a98909c89c9c895a9fa:

  ARM: dt: tegra seaboard: move battery monitor to mux'd I2C bus.

----------------------------------------------------------------

Stephen Warren (3):
      ARM: dt: tegra: add Whistler device tree file
      ARM: dt: tegra: seaboard: instantiate pinctrl-based I2C bus mux
      ARM: dt: tegra seaboard: move battery monitor to mux'd I2C bus.

 arch/arm/boot/dts/tegra20-seaboard.dts |   85 ++++++--
 arch/arm/boot/dts/tegra20-whistler.dts |  301 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/Makefile.boot      |    1 +
 3 files changed, 371 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-whistler.dts
