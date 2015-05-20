From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 May 2015 22:09:09 +0200 (CEST)
Subject: [RESEND][ PATCH v3] irqchip/gicv3-its: ITS table size should
 not be smaller than PSZ
In-Reply-To: <CY1PR0301MB074800AFD74B97267DD71BA287C20@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1432134795-661-1-git-send-email-stuart.yoder@freescale.com>
 <alpine.DEB.2.11.1505202125220.4225@nanos>
 <CY1PR0301MB074800AFD74B97267DD71BA287C20@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1505202206560.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 May 2015, Stuart Yoder wrote:

> 
> 
> > -----Original Message-----
> > From: Thomas Gleixner [mailto:tglx at linutronix.de]
> > Sent: Wednesday, May 20, 2015 2:26 PM
> > To: Yoder Stuart-B08248
> > Cc: marc.zyngier at arm.com; jason at lakedaemon.net; linux-kernel at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; Lian Minghuan-B31939
> > Subject: Re: [RESEND][ PATCH v3] irqchip/gicv3-its: ITS table size should not be smaller than PSZ
> > 
> > On Wed, 20 May 2015, Stuart Yoder wrote:
> > 
> > > when allocating a device table, if the requested allocation
> > > is smaller than the default granule size of the ITS
> > > then, we need to round up to the default size
> > >
> > 
> > So who wrote that patch? That's not a valid SOB chain ....
> 
> Minghuan wrote the original patch (v1,v2), making the functional change.
> I wrote/added the comments and submitted v3, after discussing with
> Minghuan.
> 
> Given that, what is the correct signed-off-by chain?

From: Minghuan Lian <Minghuan.Lian@freescale.com>

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
[ Stuart: Added comments and massaged changelog]
Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>

So the authorship gets attributed to Minghuan and it's noticed in the
changelog that you added comments and the changelog updates and then
sent the patch.

I'll apply it with that change, ok?

Thanks,

	tglx
