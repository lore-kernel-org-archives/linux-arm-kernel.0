From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 17 Sep 2010 15:48:25 +0530
Subject: [PATCH 03/14] davinci: map sram using MT_MEMORY_NONCACHED
	instead of MT_DEVICE
In-Reply-To: <20100917101602.GC27467@n2100.arm.linux.org.uk>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
	<20100917101602.GC27467@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307C81@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, September 17, 2010 3:46 PM
> To: Shilimkar, Santosh
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 03/14] davinci: map sram using MT_MEMORY_NONCACHED
> instead of MT_DEVICE
> 
> On Fri, Sep 17, 2010 at 03:17:47PM +0530, Santosh Shilimkar wrote:
> > On Davinci SRAM is mapped as MT_DEVICE becasue of the section
> > mapping pre-requisite instead of intended MT_MEMORY_NONCACHED
> >
> > Since the section mapping limitation gets fixed with first
> > patch in this series, the MT_MEMORY_NONCACHED can be used now.
> >
> > Have not tested this, so somebody with Davinci hardware can
> > try this out
> 
> Is this still true?
No it's not anymore.. 
It's already tested on Davinci by Kevin. I missed to remove that
