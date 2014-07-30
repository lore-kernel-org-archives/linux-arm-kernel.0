From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Jul 2014 10:30:20 +0200
Subject: [PATCH 0/3] dmaengine: sun6i: Misc fixes for the dma driver
Message-ID: <1406709023-7650-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan, Vinod,

Here are the patches that you requested previously, plus an additional
fix for a memory leak was spotted by Dan Carpenter.

Thanks,
Maxime

Maxime Ripard (3):
  dmaengine: sun6i: Remove switch statement from buswidth convertion
    routine
  dmaengine: sun6i: Free the interrupt before killing the tasklet
  dmaengine: sun6i: Fix memory leaks

 drivers/dma/sun6i-dma.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

-- 
2.0.2
