From: khilman@ti.com (Kevin Hilman)
Date: Tue, 23 Aug 2011 17:07:56 -0700
Subject: [GIT PULL] I2C: OMAP: misc. fixes for v3.2
Message-ID: <87bovfhdsz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Initially, these fixes were planned to be queued for v3.1-rc, but since
the previous series from Andy didn't make it into v3.1, it should be
queued for v3.2.

This branch is based on the for_3.2/i2c-andy branch (previous pull request.)

Please pull into your tree for linux-next.

Thanks,

Kevin

The following changes since commit 48cc1edc8f6b65a9500c8f1d93db6038167da8f0:

  I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version shown in dev_info (2011-08-23 10:51:45 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/i2c-fixes

Kevin Hilman (1):
      Revert "i2c-omap: fix static suspend vs. runtime suspend"

Shubhrajyoti D (1):
      OMAP4: I2C: Enable the wakeup in I2C_WE

 drivers/i2c/busses/i2c-omap.c |   34 ++--------------------------------
 1 files changed, 2 insertions(+), 32 deletions(-)
