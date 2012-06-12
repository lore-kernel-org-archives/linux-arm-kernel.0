From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Tue, 12 Jun 2012 11:24:44 +0530
Subject: RFC: changing DMA slave configuration API
In-Reply-To: <20120611093332.GC26681@shlinux2.ap.freescale.net>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
 <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
 <20120610112217.GD11404@n2100.arm.linux.org.uk>
 <1339390249.1927.1623.camel@vkoul-udesk3>
 <20120611093332.GC26681@shlinux2.ap.freescale.net>
Message-ID: <1339480484.1927.1625.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-11 at 17:33 +0800, Dong Aisheng wrote:
> > I think it is a good idea. And I would like to extend it even a
> little
> > bit. Do we have any users of peripheral to peripheral slave dma?
> Yes, IMX sdma does support such kind of transfer.
> The driver still does not support it currently.
> 
> > IIRC  that is not the case, or does anyone know of existence or
> plans
> > for such a h/w?
> > 
> i.MX5 and i.MX6. 

Thanks for confirming, lets keep both.

-- 
~Vinod
