From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 20 May 2015 20:03:11 +0000
Subject: [RESEND][ PATCH v3] irqchip/gicv3-its: ITS table size should not
 be smaller than PSZ
In-Reply-To: <CY1PR0301MB074800AFD74B97267DD71BA287C20@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1432134795-661-1-git-send-email-stuart.yoder@freescale.com>
 <alpine.DEB.2.11.1505202125220.4225@nanos>
 <CY1PR0301MB074800AFD74B97267DD71BA287C20@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <20150520200311.GA19834@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

On Wed, May 20, 2015 at 07:54:57PM +0000, Stuart Yoder wrote:
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

If this were your original email:
---------------------------------------
> > > 
> > > From: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > 
> > > when allocating a device table, if the requested allocation
> > > is smaller than the default granule size of the ITS
> > > then, we need to round up to the default size
> > >
> > > [sy: Added code comments and resubmitted]
> > >
> > > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---------------------------------------

it would have worked.

By adding a second 'From' line in the body of the message, 'git am' will put
the correct author on the commit.

> > So who wrote that patch? That's not a valid SOB chain ....
> 
> Minghuan wrote the original patch (v1,v2), making the functional change.
> I wrote/added the comments and submitted v3, after discussing with
> Minghuan.

thx,

Jason.
