From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue,  4 Sep 2012 15:08:00 +0300
Subject: [RFC update 0/2] dmaengine/ASoC: omap: Enable element mode in cyclic
 DMA
In-Reply-To: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
Message-ID: <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Enable the element mode (thus allowing mono playback and probably unblocking
OMAP1, OMAP2420) in OMAP dmaengine and omap-pcm.

Janusz: would it be possible for you to test Russell's series plus this on
OMAP1 to make sure that we do not broke it?

Russell: we should wait for Janusz to test this on OMAP1. Based on the feedback
we can plan on how to proceed with the dmaengine for OMAP audio.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: omap: Support for element mode in cyclic DMA
  ASoC: omap-pcm: Do not check DMA sync_mode

 drivers/dma/omap-dma.c    |  5 ++++-
 sound/soc/omap/omap-pcm.c | 10 ----------
 2 files changed, 4 insertions(+), 11 deletions(-)

-- 
1.7.12
