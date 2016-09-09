From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  9 Sep 2016 17:20:29 +0200
Subject: [GIT PULL 1/4] bus: NVIDIA Tegra ACONNECT changes for v4.9-rc1
Message-ID: <20160909152032.9550-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.9-bus

for you to fetch changes up to 3a99cb090b523f88d0a19598d39704afac11adcb:

  bus: tegra-aconnect: Use of_pm_clk_add_clk() (2016-08-16 12:22:51 +0200)

Thanks,
Thierry

----------------------------------------------------------------
bus: NVIDIA Tegra ACONNECT changes for v4.9-rc1

This contains a patch that makes use of some symbols that were added in
v4.8 and a second patch takes advantage to enable building the driver as
a loadable module.

----------------------------------------------------------------
Jon Hunter (1):
      bus: tegra-aconnect: Use of_pm_clk_add_clk()

Thierry Reding (1):
      bus: tegra-aconnect: Make symbol tristate

 drivers/bus/Kconfig          |  6 +-----
 drivers/bus/tegra-aconnect.c | 22 ++--------------------
 2 files changed, 3 insertions(+), 25 deletions(-)
