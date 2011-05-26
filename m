From: premi@ti.com (Premi, Sanjeev)
Date: Thu, 26 May 2011 15:29:37 +0530
Subject: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of gpio_bank
	structure
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-6-git-send-email-tarun.kanti@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D178024@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Thursday, May 26, 2011 3:29 PM
> To: DebBarma, Tarun Kanti; linux-omap at vger.kernel.org
> Cc: Hilman, Kevin; Shilimkar, Santosh; tony at atomide.com; 
> linux-arm-kernel at lists.infradead.org; Varadarajan, Charulatha
> Subject: RE: [PATCH 05/15] OMAP: GPIO: Make gpio_context part 
> of gpio_bank structure
> 
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org 
> > [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of 
> > DebBarma, Tarun Kanti
> > Sent: Tuesday, May 24, 2011 7:55 PM
> > To: linux-omap at vger.kernel.org
> > Cc: Hilman, Kevin; Shilimkar, Santosh; tony at atomide.com; 
> > linux-arm-kernel at lists.infradead.org; Varadarajan, Charulatha
> > Subject: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of 
> > gpio_bank structure
> > 
> > From: Charulatha V <charu@ti.com>
> > 
> > gpio_context array, which is used to save gpio bank's context,
> > is used only for OMAP3 architecture.
> > 
> > Move gpio_context as part of gpio_bank structure so that
> > it can be specific to each gpio bank and can be used for
> > any OMAP architecture
> > 
> > TODO: extend the gpio save/restore context function for OMAP4
> > architecture. This is done in one of the next patches in this
> > series
> 
> [sp] Should this TODO be part of commit?
>      BTW, this is the last patch in the series.
> 

Sorry, mistake... This showed up last on my mailbox.
~sanjeev

> ~sanjeev
> 
