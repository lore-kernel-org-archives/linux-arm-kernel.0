From: balbi@ti.com (Felipe Balbi)
Date: Mon,  6 Aug 2012 17:18:53 +0300
Subject: [PATCH 0/4] i2c: omap: few more patches
Message-ID: <1344262737-6662-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a few extra patches on top of the earlier series I sent.

With these patches, we have threaded irq support and autosuspend support for
i2c-omap driver.

All patches boot tested with pandaboard.

Felipe Balbi (4):
  i2c: omap: always return IRQ_HANDLED
  i2c: omap: switch to threaded IRQ support
  i2c: omap: remove unnecessary pm_runtime_suspended check
  i2c: omap: switch over to autosuspend API

 drivers/i2c/busses/i2c-omap.c | 53 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

-- 
1.7.12.rc0
