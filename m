From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 8 Sep 2010 13:04:55 +0530
Subject: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
In-Reply-To: <AANLkTi=chtedwbDDJnZOe5yTqobUeXz=aZYUNNUDpQQm@mail.gmail.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=chtedwbDDJnZOe5yTqobUeXz=aZYUNNUDpQQm@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D30A5@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.ml.walleij at gmail.com]
> Sent: Tuesday, September 07, 2010 11:49 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> tglx at linutronix.de; linux-omap at vger.kernel.org;
> per.xx.fransson at stericsson.com
> Subject: Re: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
> 
> 2010/9/7 Santosh Shilimkar <santosh.shilimkar@ti.com>:
> 
> > This series is just repost adding Catalin's ack to the patches and
> > combining Thomas's two rebased kexec patches.
> > It's generated against the mainline 2.6.36-rc3 + Catalin's
> > "[PATCH 0/9] Various patches for 2.6.37-rc1" series.
> >
> > Santosh Shilimkar (4):
> > ?omap4: l2x0: Override the default l2x0_disable
> > ?ARM: l2x0: Fix coding-style in the cache-l2x0.h
> > ?ARM: l2x0: Determine the cache size
> > ?ARM: l2x0: Optimise the range based operations
> >
> > Thomas Gleixner (2):
> > ?arm: Disable outer (L2) cache in kexec
> > ?arm: Implement l2x0 cache disable functions
> 
> FWIW:
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> 
Thanks !!
> Can you also include the patch by Per Fransson I sent off to
> Thomas and the list just a few days ago with the subject
> "[PATCH] ARM: ux500 specific L2 cache code"
> in this patch series?
> 
Basically I plan to push all these patches to 
RMK's patch system after getting his OK. I can push 
your patch along with that.

Is that ok with you ?

Regards,
Santosh
