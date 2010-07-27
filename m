From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 27 Jul 2010 22:00:16 +0200
Subject: Git pull request: ARM LPC32XX architecture
In-Reply-To: <20100727164945.GD17099@n2100.arm.linux.org.uk>
References: <a08234131003121244t6f914926s3ea75e98c017686a@mail.gmail.com>
	<20100312210353.GB1146@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC2FF1AE8@eu1rdcrdc1wx030.exi.nxp.com>
	<20100525172106.GA16204@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC2FF21ED@eu1rdcrdc1wx030.exi.nxp.com>
	<083DF309106F364B939360100EC290F80AC392A1F8@eu1rdcrdc1wx030.exi.nxp.com>
	<20100727164540.GC17099@n2100.arm.linux.org.uk>
	<20100727164945.GD17099@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F80AC392A25D@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Subject: Re: Git pull request: ARM LPC32XX architecture
> 
> On Tue, Jul 27, 2010 at 05:45:40PM +0100, Russell King - ARM Linux
> wrote:
> > On Tue, Jul 27, 2010 at 06:19:36PM +0200, Kevin Wells wrote:
> > > I just wanted to drop a friendly reminder on this pull request. As
> > > of yesterday, everything still built fine with the latest tree, but
> > > it's in need of some updates. Can you still pull this and I'll
> apply
> > > the updates in another patch series in the next week?
> >
> > Yes, with one change - the defconfig needs attention.  Uwe has a tool
> > which can be used to compress it.
> >
> > Even so, I don't think we want, at this stage, to antagonise Linus
> > by adding a new defconfig - we already have more than too many.
> 

Can you pull the series if I completely remove the defconfig file (for
now at least)?

> You'll also need at some point to add an apb_pclk clock (can be a dummy)
> as the amba infrastructure will want it.

I'll get this and the other updates posted in the next few days.
