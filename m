From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 13 Sep 2016 14:31:27 +0100
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for
 the v4.9 merge window
In-Reply-To: <20160913120244.GA28894@dell>
References: <20160827075544.26316-1-wens@csie.org>
 <20160827075544.26316-4-wens@csie.org>
 <20160913120244.GA28894@dell>
Message-ID: <20160913133127.GC31719@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

Try this instead.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v4.9

for you to fetch changes up to 8824ee8573483e1c91691b5be3d3730e75551dce:

  mfd: axp20x: Add support for AXP806 PMIC (2016-09-13 14:10:04 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regualtor due for the v4.9 merge window

----------------------------------------------------------------
Chen-Yu Tsai (3):
      regulator: axp20x: Support AXP806 variant
      mfd: axp20x: Add bindings for AXP806 PMIC
      mfd: axp20x: Add support for AXP806 PMIC

 Documentation/devicetree/bindings/mfd/axp20x.txt |  28 +++++-
 drivers/mfd/axp20x-rsb.c                         |   1 +
 drivers/mfd/axp20x.c                             |  72 ++++++++++++++
 drivers/regulator/axp20x-regulator.c             | 118 +++++++++++++++++++++--
 include/linux/mfd/axp20x.h                       |  60 ++++++++++++
 5 files changed, 270 insertions(+), 9 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
