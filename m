From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jul 2012 09:32:04 +0100
Subject: [PATCH] ARM: remove asm/locks.h
In-Reply-To: <20120708215712.GA6404@mudshark.cambridge.arm.com>
References: <1341262188.1911.147.camel@x61.thuisdomein>
 <20120702215203.GA25234@mudshark.cambridge.arm.com>
 <1341300030.1911.179.camel@x61.thuisdomein>
 <20120708160258.GC27030@mudshark.cambridge.arm.com>
 <1341773106.22584.9.camel@x61.thuisdomein>
 <20120708215712.GA6404@mudshark.cambridge.arm.com>
Message-ID: <20120709083204.GN16319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 08, 2012 at 10:57:12PM +0100, Will Deacon wrote:
> On Sun, Jul 08, 2012 at 07:45:06PM +0100, Paul Bolle wrote:
> > On Sun, 2012-07-08 at 17:03 +0100, Will Deacon wrote:
> > >  Please can you put this into the patch system?
> > 
> > I'm not sure what the patch system is, but I am certain that I'm not
> > allowed to put this patch into it.
> 
> Don't be so certain -- the patch system is the preferred method for submitting
> patches to arch/arm/ via Russell's tree. Since you're not familiar with it,
> I've sent the patch for you this time:
> 
>   http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7460/1

Thanks Will.

And this will be a very good thing; I am going to be away for a little
over two weeks, and I'm not intending to read much email, neither am I
intending to catch up on the huge amount of email that will be unread
after the period.  This means that any patches buried in that email will
simply be ignored by me.

Patches in the patch system will get processed once I'm back though.

But, that doesn't mean "throw your patches into the patch system" - they
still need to be reviewed by someone (and any which appear in there
without an acked-by or reviewed-by or tested-by will be discarded unless
they're trivial.)
