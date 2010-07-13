From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 09:29:07 +0100
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <AANLkTiml5z34rz7HKhZ-HyLJbfqctIrfar2ZpKyyTlYz@mail.gmail.com>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007122122.32623.arnd@arndb.de>
	<AANLkTilWwclstZiIkpiQQ_CPXgjGD2xz-GEw27hTvAp-@mail.gmail.com>
	<alpine.LFD.2.00.1007121855470.10598@xanadu.home>
	<20100713072407.GB19839@n2100.arm.linux.org.uk>
	<AANLkTiml5z34rz7HKhZ-HyLJbfqctIrfar2ZpKyyTlYz@mail.gmail.com>
Message-ID: <20100713082907.GA20590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 12:26:20PM +0400, Alexey Charkov wrote:
> 2010/7/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Mon, Jul 12, 2010 at 08:38:26PM -0400, Nicolas Pitre wrote:
> >> I think what you did is OK. ?It is best to include the whole file as
> >> generated from the machine registry database when you need it. ?This way
> >> the merge conflict can easily be resolved by simply keeping the latest
> >> version from either merged branches.
> >
> > Not quite - I'm now undoing some of the changes a mach-types update would
> > bring because people aren't talking to me to fix stuff in the machine
> > registry. ?So I'm no longer just committing the updated file off the
> > website.
> >
> > The problem is that git will automatically merge those "updates", which
> > makes it much more difficult to sort out.
> >
> 
> So the correct way is to submit a patch and just state that it
> requires an update of mach-types containing FOO and BAR, is it?

Yes please - that way I get a prompt to update mach-types.  I've
already done so last night, so it should already be up to date
there.  It'll be in mainline in a couple of days or so.
