From: khilman@ti.com (Kevin Hilman)
Date: Thu,  4 Aug 2011 07:57:34 -0700
Subject: [PATCH v2 0/2] I2C: OMAP: misc. PM-related cleanups
Message-ID: <1312469856-13276-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do some PM-related cleanup on this driver and make the runtime PM
usage more standard.

Series applies on Andy's I2C cleanup series (for_3.1/i2c-andy-2 branch
in my tree[1]) plus the misc. i2c fixes queued for v3.1-rc
(for_3.1/i2c-fixes branch) and are available in the
for_3.2/i2c-cleanup branch of my tree.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Kevin Hilman (2):
  I2C: OMAP: remove unneccesary use of pdev
  I2C: OMAP: remove dev->idle, use usage counting provided by runtime
    PM

 drivers/i2c/busses/i2c-omap.c |   77 +++++++++++++++++++++++-----------------
 1 files changed, 44 insertions(+), 33 deletions(-)

-- 
1.7.6
