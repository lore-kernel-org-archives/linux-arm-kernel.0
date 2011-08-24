From: khilman@ti.com (Kevin Hilman)
Date: Tue, 23 Aug 2011 17:10:36 -0700
Subject: [GIT PULL] I2C: OMAP: misc. cleanup for v3.2
Message-ID: <871uwbhdoj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

Here's one more I2C cleanup series for v3.2.

It applies on top of my for_3.2/i2c-fixes branch just submitted.

Please pull into your tree for linux-next.

Thanks,

Kevin


The following changes since commit f3cb1e11c4e54f4dc7e60f9513d43ffa0bbebc25:

  Revert "i2c-omap: fix static suspend vs. runtime suspend" (2011-08-23 10:51:58 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/i2c-cleanup

Kevin Hilman (3):
      I2C: OMAP: remove unneccesary use of pdev
      I2C: OMAP: remove dev->idle, use usage counting provided by runtime PM
      I2C: OMAP: remove unused function pointers from pdata

 drivers/i2c/busses/i2c-omap.c |   77 +++++++++++++++++++++++-----------------
 include/linux/i2c-omap.h      |    3 --
 2 files changed, 44 insertions(+), 36 deletions(-)
