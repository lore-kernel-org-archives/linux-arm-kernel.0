From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 10 Nov 2011 15:07:48 +0530
Subject: [PATCH v3 0/4] dmaengine: Device Tree support for Atmel DMA
In-Reply-To: <4E9C258D.3030509@atmel.com>
References: <1318438634-11826-1-git-send-email-nicolas.ferre@atmel.com>
 <4E9C258D.3030509@atmel.com>
Message-ID: <1320917868.32205.1200.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-10-17 at 14:54 +0200, Nicolas Ferre wrote:
> On 10/12/2011 06:57 PM, Nicolas Ferre :
> > This series add the device tree support to Atmel DMA controller driver:
> > at_hdmac.
> > The removal of platform data ease the conversion to device tree. It also have
> > the additional benefit of being simpler and cleaner.
> > 
> > Nicolas Ferre (4):
> >       dmaengine: at_hdmac: platform data move to use .id_table
> >       dmaengine: at_hdmac: add device tree support
> >       ARM: at91/dma: remove platform data from DMA controller
> >       ARM: at91/dma: DMA controller registering with DT support
> > 
> >  .../devicetree/bindings/dma/atmel-dma.txt          |   14 ++++
> >  arch/arm/mach-at91/at91sam9g45_devices.c           |   17 ++---
> >  arch/arm/mach-at91/at91sam9rl_devices.c            |    8 +--
> >  arch/arm/mach-at91/include/mach/at_hdmac.h         |   10 ---
> >  drivers/dma/at_hdmac.c                             |   76 +++++++++++++++++---
> >  drivers/dma/at_hdmac_regs.h                        |    8 ++
> >  6 files changed, 97 insertions(+), 36 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/atmel-dma.txt
> 
> Vinod,
> 
> I have just rebased the dmaengine at_hdmac driver patches on top of your
> "next" branch as a "v4" series. I send it to you with Grant's "Acked-by"
> right now.
Thanks applied now

-- 
~Vinod
