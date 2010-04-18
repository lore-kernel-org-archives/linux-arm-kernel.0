From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sun, 18 Apr 2010 10:31:49 +0530
Subject: [PATCH v2] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002
In-Reply-To: <20100417183336.GB24299@n2100.arm.linux.org.uk>
References: <1271492144-26995-1-git-send-email-santosh.shilimkar@ti.com>
	<20100417183336.GB24299@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4F165C4@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Sunday, April 18, 2010 12:04 AM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org; Catalin Marinas; Sundar R IYER
> Subject: Re: [PATCH v2] ARM: Fix "BUG: scheduling while atomic: swapper/0/0x00000002
> 
> On Sat, Apr 17, 2010 at 01:45:44PM +0530, Santosh Shilimkar wrote:
> > +		/*
> > +		 * Since idle thread getting re-used, call
> > +		 * init_idle() to set up the idle thread for given
> > +		 * CPU. Additionally it also resets the preempt count
> 
> "Since this idle thread is being re-used, call
> init_idle() to reinitialize the thread structure."
> 
> I don't think we need to mention the preempt count explicitly because
> that's a detail of reinitializing the thread structure.
Ok. 
Will fix the description and if you are ok can submit to patch system

Regards,
Santosh
