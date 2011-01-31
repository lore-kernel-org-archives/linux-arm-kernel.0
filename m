From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 13:00:44 +0100
Subject: dmaengine: i.MX dma fixes
Message-ID: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following contains fixes for the i.MX dma driver.

Sascha

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:

  Linux 2.6.38-rc2 (2011-01-21 19:01:34 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6 dmaengine-imxdma

Sascha Hauer (4):
      dmaengine i.MX dma: set maximum segment size for our device
      dmaengine i.MX dma: check sg entries for valid addresses and lengths
      dmaengine i.MX DMA: do not initialize chan_id field
      dmaengine i.MX dma: initialize dma capabilities outside channel loop

 drivers/dma/imx-dma.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)
