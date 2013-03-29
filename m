From: pmeerw@pmeerw.net (Peter Meerwald)
Date: Fri, 29 Mar 2013 15:36:07 +0100 (CET)
Subject: [RFC] dmaengine: omap-dma: Start DMA without delay
In-Reply-To: <1364566323-24144-1-git-send-email-peter.ujfalusi@ti.com>
References: <1364566323-24144-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.01.1303291533540.26456@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Remove the use of a tasklet to start the DMA channel when issue_pending is
> called.
> The use of tasklet delays the DMA start which can cause issues at drivers,
> for example the audio drivers expect that the DMA is started right away.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I've reported the problem and now tested the patch applied on top of 
3.8.5, running on beagle-xm; sounds good, so

Tested-by: Peter Meerwald <p.meerwald@bct-electronic.com>

-- 

Peter Meerwald
+43-664-2444418 (mobile)
