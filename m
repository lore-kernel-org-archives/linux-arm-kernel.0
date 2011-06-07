From: khilman@ti.com (Kevin Hilman)
Date: Tue,  7 Jun 2011 11:22:28 -0700
Subject: [PATCH 0/3] I2C: OMAP: PM related cleanup
Message-ID: <1307470951-22801-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a small series of PM-related cleanups for the OMAP I2C driver.

Series applies on top of the other cleanup series from Andy Green:

  [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is... from driver

and is available from git here:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git wip/i2c

Kevin Hilman (3):
  I2C: OMAP: remove unneccesary use of pdev
  I2C: OMAP: remove dev->idle, use usage counting provided by runtime
    PM
  I2C: OMAP: remove racy suspend/resume callbacks

 drivers/i2c/busses/i2c-omap.c |   70 +++++++++++++++-------------------------
 1 files changed, 26 insertions(+), 44 deletions(-)

-- 
1.7.4
