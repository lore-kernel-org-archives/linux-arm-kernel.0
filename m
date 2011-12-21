From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Dec 2011 12:58:06 +0800
Subject: [PATCH 0/4] Fix the left DMA_NONE from dma_transfer_direction
 migration
In-Reply-To: <1324442451.1641.10109.camel@vkoul-udesk3>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1324373044.1641.10096.camel@vkoul-udesk3>
 <20111220125401.GA5129@S2101-09.ap.freescale.net>
 <1324440424.1641.10104.camel@vkoul-udesk3>
 <20111221044517.GD5983@S2101-09.ap.freescale.net>
 <1324442451.1641.10109.camel@vkoul-udesk3>
Message-ID: <20111221045805.GE5983@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 10:10:51AM +0530, Vinod Koul wrote:
> On Wed, 2011-12-21 at 12:45 +0800, Shawn Guo wrote:
> > > 
> > The term PIO here may not the one on your mind.  I call it 'mxs-dma
> > pio'.  In this mode, mxs-dma hardware can write values into mmc
> > controller register without cpu involved.
> what do you mean by values here?
> 
The register values that we want to write to mmc controller registers
in this case.

-- 
Regards,
Shawn
