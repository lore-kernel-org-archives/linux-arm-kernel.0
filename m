From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 May 2016 13:49:45 +0100
Subject: [PATCH 0085/1529] Fix typo
In-Reply-To: <20160521122157.GA6289@li61-168.members.linode.com>
References: <20160521114759.3760-1-andrea.gelmini@gelma.net>
 <20160521115556.GV19428@n2100.arm.linux.org.uk>
 <20160521122157.GA6289@li61-168.members.linode.com>
Message-ID: <20160521124945.GW19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 21, 2016 at 12:21:57PM +0000, Andrea Gelmini wrote:
> On Sat, May 21, 2016 at 12:55:56PM +0100, Russell King - ARM Linux wrote:
> > On Sat, May 21, 2016 at 01:47:59PM +0200, Andrea Gelmini wrote:
> > > Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> > > ---
> > >  arch/arm/include/asm/ucontext.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/include/asm/ucontext.h b/arch/arm/include/asm/ucontext.h
> > > index 14749ae..b4d2d0f 100644
> > > --- a/arch/arm/include/asm/ucontext.h
> > > +++ b/arch/arm/include/asm/ucontext.h
> > > @@ -8,7 +8,7 @@
> > >   * ucontext now has room for all registers which need to be saved and
> > >   * restored.  Coprocessor registers are stored in uc_regspace.  Each
> > >   * coprocessor's saved state should start with a documented 32-bit magic
> > > - * number, followed by a 32-bit word giving the coproccesor's saved size.
> > > + * number, followed by a 32-bit word giving the coprocessor saved size.
> > 
> > The original is fine, and I'd say is more correct.
> 
> My point was about the spelling: coproccesor (double C, single S).

I didn't spot that, sorry.

> I don't resend a new version of the patch.
> My interest is notify it, don't care to have commit in kernel for such
> little thing.
> I guess is easier if you fix it with next batch of your patches.

Well, I also don't care enough to fix the spelling either.  I also
don't see the point of applying a patch which results in it still
being wrong.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
