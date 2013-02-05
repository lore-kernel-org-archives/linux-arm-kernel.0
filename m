From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 13:58:23 +0800
Subject: [GIT PULL] mxs soc changes for 3.9
Message-ID: <20130205055822.GD10807@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are mxs soc changes for 3.9.  I have the pull request based on
arm-soc/clocksource/cleanup to save conflict.  Please pull, thanks.

Shawn

The following changes since commit 77cc982f6a3b33a5aa058ad3b20cda8866db2948:

  clocksource: use clockevents_config_and_register() where possible (2013-01-14 10:12:42 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-soc-3.9

for you to fetch changes up to e1ab0056df613662929290f385590da2cccb8c19:

  ARM: mxs_defconfig: Select CONFIG_DEVTMPFS_MOUNT (2013-02-05 11:28:28 +0800)

----------------------------------------------------------------
mxs soc changes for 3.9

 - A couple of optimization on timer
 - Some updates on mxs_defconfig

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: mxs_defconfig: Select CONFIG_DEVTMPFS_MOUNT

Marek Vasut (1):
      ARM: mxs: Update mxs_defconfig

Torben Hohn (2):
      ARM: mxs: use apbx bus clock to drive the timers on timrotv2
      ARM: mxs: decrease mxs_clockevent_device.min_delta_ns to 2 clock cycles

 arch/arm/configs/mxs_defconfig |   64 +++++++++++++++++++---------------------
 arch/arm/mach-mxs/timer.c      |   12 ++++----
 drivers/clk/mxs/clk-imx28.c    |    2 +-
 3 files changed, 39 insertions(+), 39 deletions(-)
