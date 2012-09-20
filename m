From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Sep 2012 09:45:28 -0600
Subject: [GIT PULL] ARM: tegra: second round of device tree changes
Message-ID: <1348155928-12405-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch includes some late device tree changes for Tegra:

A property is added to Whistler's device tree to enable the PMIC to
act as the pm_power_off() implementation.

A number of new device tree are added for boards from Avionic Design.

----------------------------------------------------------------

The following changes since commit 44b12ef78106141574f038852d013fd3207acb23:

  ARM: dt: tegra: configure power off for some boards

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-dt2

for you to fetch changes up to 175f16fa38977dfed9f9fe247279516ce892fb15:

  ARM: tegra: Add Avionic Design Tamonten Evaluation Carrier support

----------------------------------------------------------------

Stephen Warren (1):
      ARM: dt: tegra: whistler: configure power off

Thierry Reding (5):
      ARM: tegra: dts: Add pwm label
      ARM: tegra: Add Avionic Design Tamonten support
      ARM: tegra: Add Avionic Design Plutux support
      ARM: tegra: Add Avionic Design Medcom-Wide support
      ARM: tegra: Add Avionic Design Tamonten Evaluation Carrier support

 arch/arm/boot/dts/tegra20-medcom-wide.dts |   58 +++
 arch/arm/boot/dts/tegra20-plutux.dts      |   50 +++
 arch/arm/boot/dts/tegra20-tamonten.dtsi   |  449 ++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20-tec.dts         |   53 +++
 arch/arm/boot/dts/tegra20-whistler.dts    |    2 +
 arch/arm/boot/dts/tegra20.dtsi            |    2 +-
 arch/arm/boot/dts/tegra30.dtsi            |    2 +-
 arch/arm/mach-tegra/Makefile.boot         |    3 +
 8 files changed, 617 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-medcom-wide.dts
 create mode 100644 arch/arm/boot/dts/tegra20-plutux.dts
 create mode 100644 arch/arm/boot/dts/tegra20-tamonten.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-tec.dts
