From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Apr 2011 13:52:54 -0600
Subject: [PATCH 5/6] ARM: nmk: update GPIO chained IRQ handler to
	entry/exit functions
In-Reply-To: <BANLkTim9dUBbcDGpDOwuWF9dVdS_4TCr_g@mail.gmail.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-6-git-send-email-will.deacon@arm.com>
	<BANLkTikNANiZm+K3-9SdDb9MOWGxgpEGNg@mail.gmail.com>
	<1303153488.23764.9.camel@e102144-lin.cambridge.arm.com>
	<BANLkTim9dUBbcDGpDOwuWF9dVdS_4TCr_g@mail.gmail.com>
Message-ID: <20110419195254.GC13275@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 01:46:53AM +0200, Linus Walleij wrote:
> 2011/4/18 Will Deacon <will.deacon@arm.com>:
> 
> >> BUT I want it to go through Grants gpio tree. The reason is that
> >> I plan to consolidate this driver into drivers/gpio/* and I don't want
> >> collisions in merges.
> >
> > Ok. Will Grant just pick it up when he's happy with it?
> 
> If not picked up, I'll queue it on the top of my patch series when moving it
> to drivers/gpio...

Go ahead and put it in your series.  Since you're going to be doing
consolidation work on it, I'd rather deal with it all at once.

g.
