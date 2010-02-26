From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Feb 2010 19:59:45 +0000
Subject: [PULL] Pull request for for-rmk/samsung5
In-Reply-To: <20100226160924.GB24864@trinity.fluff.org>
References: <20100225000919.GA28433@fluff.org.uk>
	<20100225205301.GG3101@n2100.arm.linux.org.uk>
	<20100226160924.GB24864@trinity.fluff.org>
Message-ID: <20100226195944.GA23933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2010 at 04:09:24PM +0000, Ben Dooks wrote:
> On Thu, Feb 25, 2010 at 08:53:01PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Feb 25, 2010 at 12:09:19AM +0000, Ben Dooks wrote:
> > > Sorry for the late request, but haven't been very well. Quite a bit of
> > > this update has been on list for a while, but only just been merged
> > > together into one tree.
> > > 
> > > This is the last of the Samsung updates that need to go via RMK, they
> > > are mostly plat-s3c/plat-s3c64xx and machine squashed and the new
> > > S5P6442 and S5PV210 code.
> > > 
> > > Included are some updates for the current code to avoid build or runtime
> > > problems with other updates such as via the ASoC tree.
> > > 
> > > I will be doing a seperate set of updates direct to Linus once these are
> > > merged to fix and outstanding problems, any updates such as S3C2443 clock
> > > rewrite and anything else not directly relying on arch/arm modifications.
> > > 
> > > There will also be a set of documentation updates to deal with the current
> > > shifts and outline anything else that needs to be done.
> > > 
> > > Anything urgent, please cc: me directly.
> > > 
> > > The following changes since commit ab5d97db1c6ced3e95c00d097931471707032b1f:
> > >   Ben Dooks (1):
> > >         ARM: SAMSUNG: Fix bad use of __initdata for s3c_register_clocks()
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.fluff.org/bjdooks/linux.git for-rmk/samsung5
> > 
> > This gives me conflicts in arch/arm/Makefile and arch/arm/Kconfig.  I'll
> > need to investigate, which I'll do over the weekend.
> 
> Very probably, this is based of the for-rmk/samsung3 branch which has
> very likely diverged from your branch. Thanks for looking at it.

When you say that, are you saying that the contents of the samsung3
branch which I pulled aren't relevant anymore?
