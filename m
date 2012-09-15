From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Sep 2012 22:31:52 +0100
Subject: [PATCH] clk: Make the managed clk functions generically available
In-Reply-To: <5050F3DB.1050202@metafoo.de>
References: <1347202862-1617-1-git-send-email-lars@metafoo.de>
 <20120909235059.GA2643@sirena.org.uk>
 <20120910001524.GL13739@n2100.arm.linux.org.uk>
 <20120910002020.GB16249@opensource.wolfsonmicro.com>
 <20120910003913.GM13739@n2100.arm.linux.org.uk> <504F4E36.20309@metafoo.de>
 <1347375033.27206.3.camel@sauron.fi.intel.com>
 <504FE633.2090304@snapgear.com> <5050F3DB.1050202@metafoo.de>
Message-ID: <20120915213151.GM12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 10:43:07PM +0200, Lars-Peter Clausen wrote:
> I wouldn't mind having this merged sooner rather than later, there is at least
> one driver in next which is currently broken due to the missing devm_clk_get.
> Russell what's your plan for the patch? Maybe under the given circumstances it
> makes sense to let it go through the m68k tree.

Ok, I've merged it but there was no indication in the patch that it was
supposed to be a fix... there's no cc: to stable.  Does it need to go to
stable?  When was this brokenness introduced?  What's the story for the
m68k bit?

(Cc on this thread to stable added so they can hear the reply... so if
it does end up with a Cc: being added to the commit, they have the
background... this is *not* a stable submission request.)
