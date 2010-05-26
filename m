From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 May 2010 06:51:29 -0700
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100526075059.GA25435@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100522215848.GB29889@n2100.arm.linux.org.uk>
	<20100526004418.GM9645@atomide.com>
	<20100526075059.GA25435@n2100.arm.linux.org.uk>
Message-ID: <20100526135128.GN9645@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100526 00:45]:
> On Tue, May 25, 2010 at 05:44:18PM -0700, Tony Lindgren wrote:
> 
> > After applying the next patch in your lmb branch "ARM: OMAP: Convert
> > to use ->reserve method to reserve boot time memory" tux still works
> > on 5912osk, but not on n900. The difference is that osk5912 uses
> > the old omapfb code.
> 
> I guess this is because I don't have board-n900.c in my tree.  All OMAP
> boards need a ".reserve = omap_reserve," line added in their machine
> descriptor.

It's there but well hidden, board-rx51.c is the one for n900.
 
> I just noticed that board-n8x0.c contains more than one machine descriptor,
> which I've now fixed up.

OK good catch.

> > Anyways, I've picked the patches from lmb branch up to the one below
> > into omap-testing. Will add more of them once we get them working.
> 
> You should now be able to pick all but the last patch.

Yeah I'll do that once the dss2 code has been verified to work.

Regards,

Tony
