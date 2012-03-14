From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Mar 2012 16:44:54 +0530
Subject: [PATCH v3 00/13] dmaengine: imx-dma: merge dma arch code into
 dmaengine.
In-Reply-To: <CACKLOr0XzE0PZk=k5xQQvOA_5dfBk1mYDVyKCep36=3w7ugwWg@mail.gmail.com>
References: <1331306449-28591-1-git-send-email-javier.martin@vista-silicon.com>
 <20120309174411.GI3852@pengutronix.de>
 <CACKLOr0XzE0PZk=k5xQQvOA_5dfBk1mYDVyKCep36=3w7ugwWg@mail.gmail.com>
Message-ID: <1331723694.1727.28.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-03-14 at 08:43 +0100, javier Martin wrote:
> On 9 March 2012 18:44, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Fri, Mar 09, 2012 at 04:20:36PM +0100, Javier Martin wrote:
> >> The following series have to be applied on top of the following patches:
> >> [PATCH v2 1/2] dmaengine: Add support for MEMCPY for imx-dma.
> >> [PATCH v3 2/2] dmaengine: Add support for multiple descriptors for imx-dma.
> >>
> >> As discussed with Vinod and Sascha, the file 'arch/arm/mach-imx/dma-v1.c'
> >> is deprecated and no new patches are accepted for it.
> >>
> >> This series merges this code into the imx-dma.c dmaengine driver.
> >
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> >
> 
> Vinod,
> I think with Sascha's ack, this series is ready to be merged. It's
> quite important for us that it makes it for 3.4.
> 
> Please, don't forget the following patch too, which is meant to be
> applied on top of this series:
> 
> [PATCH] dmaengine: i.MX: Add support for interleaved transfers.
> 
This is my merge queue which means I will merged it after the cookie
fixes (hate rebasing that series again)

-- 
~Vinod
