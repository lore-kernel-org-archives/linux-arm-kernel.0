From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Sep 2013 10:37:47 +0100
Subject: [GIT PULL] Final pull-request due for the v3.12 merge window
Message-ID: <20130902093747.GI12341@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2b274fe522e9d5ac7397e07e3516bb10e3c2ee92:

  mfd: 88pm805: Fix potential NULL pdata dereference (2013-09-02 11:00:16 +0200)

are available in the git repository at:

  git://git.linaro.org/people/ljones/mfd.git tags/mfd-lee-3.12-2

for you to fetch changes up to 02a0bf6e351de6bcda4ddeeb2af34197a4e6d591:

  mfd: ucb1x00-core: Rewrite ucb1x00_add_dev() (2013-09-02 10:22:46 +0100)

----------------------------------------------------------------
mfd-lee-3.12-2

These are the final patches due for the v3.12 merge window.

----------------------------------------------------------------
Lee Jones (3):
      mfd: ab8500-debugfs: Apply a check for -ENOMEM after allocating memory for sysfs
      mfd: ab8500-debugfs: Apply a check for -ENOMEM after allocating memory for event name
      mfd: ucb1x00-core: Rewrite ucb1x00_add_dev()

Sachin Kamat (7):
      mfd: omap-usb-host: Staticize usbhs_driver_name
      mfd: db8500-prcmu: Use ANSI function declaration
      mfd: db8500-prcmu: Staticize clk_mgt
      mfd: ab8500-debugfs: Staticize local variables
      mfd: timberdale: Staticize local variables
      mfd: timberdale: Remove redundant break
      mfd: timberdale: Use module_pci_driver

 drivers/mfd/ab8500-debugfs.c | 14 ++++++++++----
 drivers/mfd/db8500-prcmu.c   |  4 ++--
 drivers/mfd/omap-usb-host.c  |  2 +-
 drivers/mfd/timberdale.c     | 34 +++-------------------------------
 drivers/mfd/ucb1x00-core.c   | 28 +++++++++++++++-------------

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
