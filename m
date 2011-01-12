From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Jan 2011 11:18:13 +0100
Subject: dmaengine: Fix i.MX sdma firmware loading
Message-ID: <1294827494-15092-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The firmware loading in the i.MX sdma engine is currently broken. The
following patch fixes this. Dan, please forward this patch for current
-rc.

Sascha Hauer (1):
      dmaengine i.MX SDMA: Fix firmware loading

 drivers/dma/imx-sdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
