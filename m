From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 12:59:27 +0100
Subject: dmaengine: i.MX SDMA fixes
Message-ID: <1296475172-23900-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following contains fixes for the i.MX SDMA driver.

Sascha

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:

  Linux 2.6.38-rc2 (2011-01-21 19:01:34 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6 dmaengine-sdma

Sascha Hauer (5):
      dmaengine i.MX sdma: set maximum segment size for our device
      dmaengine i.MX sdma: check sg entries for valid addresses and lengths
      dmaengine i.MX SDMA: do not initialize chan_id field
      dmaengine i.MX SDMA: initialize dma capabilities outside channel loop
      dmaengine i.MX SDMA: reserve channel 0 by not registering it

 drivers/dma/imx-sdma.c |   60 ++++++++++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 25 deletions(-)
