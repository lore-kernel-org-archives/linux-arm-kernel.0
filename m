From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 8 Jul 2011 22:28:33 +0530
Subject: [RFC PATCH v4] Consolidate SRAM support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D9B5940@dbde02.ent.ti.com>
References: <20110512174546.GB8633@n2100.arm.linux.org.uk>
	<1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D9B5940@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D9B5949@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 22:21:52, Nori, Sekhar wrote:
> Hi Jean-Christophe,
> 
> On Thu, May 26, 2011 at 06:32:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > From: Russell King - ARM Linux <linux@arm.linux.org.uk>

> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index f4b7dfa..5ec5e5f 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -848,6 +848,7 @@ config ARCH_DAVINCI
> >  	bool "TI DaVinci"
> >  	select GENERIC_CLOCKEVENTS
> >  	select ARCH_REQUIRE_GPIOLIB
> > +	select GENERIC_ALLOCATOR
> >  	select ZONE_DMA
> >  	select HAVE_IDE
> >  	select CLKDEV_LOOKUP
> 
> GENERIC_ALLOCATOR is already selected for
> DaVinci (below the "select CLKDEV_LOOKUP"
> line).
> 
> Please drop this hunk.

This mail popped up at the top of my inbox
as an unread message and I replied to it
without looking at the sent date assuming
it is a patch resend.

Sorry about the noise.

Thanks,
Sekhar
