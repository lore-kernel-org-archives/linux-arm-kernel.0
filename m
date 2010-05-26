From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 27 May 2010 01:10:02 +0200
Subject: Git pull request: ARM LPC32XX architecture
In-Reply-To: <20100525172106.GA16204@n2100.arm.linux.org.uk>
References: <a08234131003121244t6f914926s3ea75e98c017686a@mail.gmail.com>
	<20100312210353.GB1146@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC2FF1AE8@eu1rdcrdc1wx030.exi.nxp.com>
	<20100525172106.GA16204@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F80AC2FF21ED@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, May 25, 2010 10:21 AM
> To: Kevin Wells
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: Git pull request: ARM LPC32XX architecture
> 
> On Tue, May 25, 2010 at 05:27:12PM +0200, Kevin Wells wrote:
> > It's been a few months since I've posted this patch set and I'd still
> > like to get it pulled.
> 
> Sorry, it got buried beneath _lots_ of email.
> 
> However, I've sent my second and final pull request to Linus yesterday
> evening.  So far Linus hasn't pulled my tree, so I can't touch it at
> the moment.
> 
> I think this stuff has missed this window as well. ;(
> 

Thanks, I figured you probably had your hands full.

> > Can you pull the original series plus the slab.h patch? (breaks
> bisect)?
> > Or do you want the slab.h fix included in the correct order in the
> > Series to be bisect friendly?
> 
> Well, there's two ways to get around that - both of which you need to
> ensure that no one's pulled your tree yet.
> 
> 1. Re-do the patches such that the missing include(s) are added.
> 
> 2. rebase the series on something more recent and fix the slab.h thing
>    along the way.
> 
> Either way means that the series remains bisect-able after merging.
> 
> This is not something that should be done lightly however - these kinds
> of changes mean that anyone who has pulled your tree is in for some
> grief.

The updated full series is available from:
git://git.lpclinux.com/linux-2.6-lpc wells/lpc32xx-arch

This has been rebased on 2.6.34.
A pull of this series should play nice with the previous series if someone has already pulled it..
