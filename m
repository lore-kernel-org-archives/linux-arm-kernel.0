From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 7 Oct 2012 17:41:15 +0200
Subject: [PATCH] ARM: sort select statements alphanumerically
In-Reply-To: <20121007133048.GE28061@n2100.arm.linux.org.uk>
References: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
 <20121007131440.GC12801@game.jcrosoft.org>
 <20121007133048.GE28061@n2100.arm.linux.org.uk>
Message-ID: <20121007154115.GD12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:30 Sun 07 Oct     , Russell King - ARM Linux wrote:
> On Sun, Oct 07, 2012 at 03:14:40PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 17:22 Sat 06 Oct     , Russell King wrote:
> > > This commit is likely to change as we get closer to the end of the merge
> > > window, as other changes get merged into Linus' tree.  I will be refreshing
> > > this from time to time, and keeping it out of linux-next, as it will cause
> > > more pain than its worth to put it into linux-next.
> > > 
> > > Anyone who wants to give this a review to check that it's correct are welcome,
> > > but I don't think it would be appropriate to collect attributation tags for
> > > it, as this won't be the final patch.
> > > 
> > > This patch is intentionally broken to prevent Linus from applying it - this
> > > is information only!
> > > 
> > > Anyone who wants to apply it can do so by first running this patch through:
> > > 
> > > 	sed 's/^-- /@@ /'
> > > 
> > >  arch/arm/Kconfig                  |  399 ++++++++++++++++++-------------------
> > >  arch/arm/common/Kconfig           |    4 +-
> > >  arch/arm/mach-at91/Kconfig        |   26 ++--
> > this maybe conflict with pinctrl support
> 
> Of course it will - and this tells me that you did not read the comments
> I left before the diffstat.  It's almost guaranteed to conflict with
> virtually all the changes going into this merge window.
> 
> > Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> And this also confirms that too; I said I didn't want to add attributations
> to it because you aren't going to be acking the patch which will eventually
> be committed.
> 
> In sort, this patch _will_ be recreated by the script at the end of the
> merge window, and whatever that patch ends up being is what will get
> merged.  It's very likely (because of the inherent conflicts in doing
> this) that it _will_ be different from this one.
> 
> What that means is if I add (your) acked-by to it, I will be adding it
> to a different patch to the one you've sent this to.
> 
> What I want people to do with this is review it and make sure that the
> script hasn't created any obvious mistakes; I've already done that but
> the more eyes we get on it the better.

I did read it I just point it out so if people try to apply over it then known

and just point out that I see no issue on at91

Best Regards,
J.
