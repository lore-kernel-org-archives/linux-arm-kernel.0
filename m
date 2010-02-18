From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 18 Feb 2010 23:03:47 +0530
Subject: [PATCH 7/9] omap4: Add auto-generated irq and dma headers
In-Reply-To: <alpine.DEB.2.00.1002181014470.24812@utopia.booyaka.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-4-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-5-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-6-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-7-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1002181014470.24812@utopia.booyaka.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C417F8FE@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Thursday, February 18, 2010 10:53 PM
> To: Shilimkar, Santosh
> Cc: tony at atomide.com; linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Cousson,
> Benoit
> Subject: Re: [PATCH 7/9] omap4: Add auto-generated irq and dma headers
> 
> Hello Santosh,
> 
> thanks for sending these in.  One minor comment:
> 
> On Thu, 18 Feb 2010, Santosh Shilimkar wrote:
> 
> > These files are generated along with the HWMOD and will eventually be
> > in the existing header files as soon as all drivers will be migrate to
> > omap_hwmod / omap_device.
> >
> > The dma-44xx.h file should be in 'arch/arm/mach-omap2/include/mach/',
> > but this would need dma.h header also present in the mach directory to
> > make local include possible, like what is done for irq.h. Then the
> > script is needed to modify the drivers to include 'mach/dma.h' instead
> > of 'plat/dma.h'. This would be a bigger change and hence left out for now
> 
> I think I originally wrote the DMA generator script, so please add a Nokia
> copyright and put my name in there also.  After that point, it has my ack.
Sure Paul. Will add that information and send updated patch.

Benoit,
We need to update the scripts and regenerate this. I will do that.

Regards,
Santosh 
