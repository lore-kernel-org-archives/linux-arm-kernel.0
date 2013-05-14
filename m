From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 14 May 2013 10:19:56 +0100
Subject: [GIT PULL] MFD: Fixes due for the v3.10 -rc:s
Message-ID: <20130514091956.GG3297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ljones/mfd.git for-mfd-fixes

for you to fetch changes up to bc475aeb21c85f956c98014cae887f311c68b192:

  mfd: db8500-prcmu: Supply the pdata_size attribute for db8500-thermal (2013-05-14 09:58:15 +0100)

----------------------------------------------------------------
Arnd Bergmann (1):
      mfd: ab8500: Debugfs code depends on gpadc

Fabio Baltieri (4):
      mfd: abx500-core: Fix sparse warning
      mfd: ab8500-sysctrl: Fix sparse warning
      mfd: ab8500-sysctrl: Set sysctrl_dev during probe
      mfd: ab8500-sysctrl: Let sysctrl driver work without pdata

Lee Jones (3):
      mfd: ab8500-gpadc: Suppress 'ignoring regulator_enable() return value' warning
      mfd: ab8500-core: Use the correct driver name when enabling gpio/pinctrl
      mfd: db8500-prcmu: Supply the pdata_size attribute for db8500-thermal

Linus Walleij (1):
      mfd: ab8500: Pass AB8500 IRQ to debugfs code by resource

 drivers/mfd/Kconfig          |    2 +-
 drivers/mfd/ab8500-core.c    |   21 ++++++++++++++++++---
 drivers/mfd/ab8500-debugfs.c |   16 ++++++++++++----
 drivers/mfd/ab8500-gpadc.c   |    7 +++++--
 drivers/mfd/ab8500-sysctrl.c |    9 +++++----
 drivers/mfd/abx500-core.c    |    2 +-
 drivers/mfd/db8500-prcmu.c   |    1 +
 7 files changed, 43 insertions(+), 15 deletions(-)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
