From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 25 May 2011 17:53:36 +0530
Subject: [PATCH 2/2] dmaengine: add TODO items for future work on dma
	drivers
In-Reply-To: <BANLkTinP-5z0ecf0zvrEnLOSDvOhLzMKDw@mail.gmail.com>
References: <1306323570-11133-1-git-send-email-vinod.koul@intel.com>
	<1306323570-11133-3-git-send-email-vinod.koul@intel.com>
	<BANLkTinP-5z0ecf0zvrEnLOSDvOhLzMKDw@mail.gmail.com>
Message-ID: <1306326216.30236.196.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-25 at 14:47 +0200, Linus Walleij wrote:
> 2011/5/25 Koul, Vinod <vinod.koul@intel.com>:
> 
> > From: Vinod Koul <vinod.koul@intel.com>
> >
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  drivers/dma/TODO |   12 ++++++++++++
> >  1 files changed, 12 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/dma/TODO
> >
> > diff --git a/drivers/dma/TODO b/drivers/dma/TODO
> > new file mode 100644
> > index 0000000..b67d184
> > --- /dev/null
> > +++ b/drivers/dma/TODO
> > @@ -0,0 +1,12 @@
> > +TODO for slave dma
> > +
> > +1. Move remaining drivers to use new slave interface
> 
> Here is the hitlist:
> - find arch/arm/ |grep -e "dma.c$"
> - arch/arm/mach-s3c64xx/dma.c need to be merged into
>   drivers/dma/amba-pl08x.c - make adjustments for local
>   deviations
> 
> Or were you mainly talking about the drivers already in
> drivers/dma?
I was talking about current drivers still using old pointer mechanism
for passing slave info.

And yes this should be in list too, and this is where I may need your
help :) I will try to compile the list for drivers which should be moved

-- 
~Vinod
