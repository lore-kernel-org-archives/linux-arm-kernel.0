From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 19 Sep 2012 08:55:11 +0200
Subject: [PATCH] clk: Make the managed clk functions generically available
In-Reply-To: <20120918204014.GY12245@n2100.arm.linux.org.uk>
References: <20120910003913.GM13739@n2100.arm.linux.org.uk>
 <504F4E36.20309@metafoo.de>
 <1347375033.27206.3.camel@sauron.fi.intel.com>
 <504FE633.2090304@snapgear.com> <5050F3DB.1050202@metafoo.de>
 <20120915213151.GM12245@n2100.arm.linux.org.uk>
 <20120918080037.GA15982@avionic-0098.mockup.avionic-design.de>
 <20120918093536.GV12245@n2100.arm.linux.org.uk>
 <20120918112555.GA21004@avionic-0098.mockup.avionic-design.de>
 <20120918204014.GY12245@n2100.arm.linux.org.uk>
Message-ID: <20120919065510.GA3213@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 09:40:14PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 18, 2012 at 01:25:55PM +0200, Thierry Reding wrote:
> > On Tue, Sep 18, 2012 at 10:35:36AM +0100, Russell King - ARM Linux wrote:
> > > On Tue, Sep 18, 2012 at 10:00:37AM +0200, Thierry Reding wrote:
> > > > On Sat, Sep 15, 2012 at 10:31:52PM +0100, Russell King - ARM Linux wrote:
> > > > > On Wed, Sep 12, 2012 at 10:43:07PM +0200, Lars-Peter Clausen wrote:
> > > > > > I wouldn't mind having this merged sooner rather than later, there is at least
> > > > > > one driver in next which is currently broken due to the missing devm_clk_get.
> > > > > > Russell what's your plan for the patch? Maybe under the given circumstances it
> > > > > > makes sense to let it go through the m68k tree.
> > > > > 
> > > > > Ok, I've merged it but there was no indication in the patch that it was
> > > > > supposed to be a fix... there's no cc: to stable.  Does it need to go to
> > > > > stable?  When was this brokenness introduced?  What's the story for the
> > > > > m68k bit?
> 
> I said abouve "I've merged it" - that means, I've put it in my
> tree...
> 
> > > > What tree is this supposed to go through? I've checked your ARM tree as
> > > > well as Mike's clock tree but neither seem to carry this patch. The
> > > > reason I ask is because I want to take a patch series that converts the
> > > > Unicore32 PWM code to the PWM framework into linux-next but it depends
> > > > on this patch as well.
> > > 
> > > It /is/ in my tree (you'll notice that it is in linux-next.)  You're
> > > probably looking at my Linaro tree instead, which doesn't carry
> > > anything which isn't about to be sent to Linus.
> > 
> > I must be blind then. next-20120918 doesn't have it. And looking at your
> > tree here[0] doesn't show the commit either.
> 
> Hmm, it's possible I didn't push the tree out... well, I have done so
> now, so it should be visible from tonight onwards and should be in
> -next sometime during the next couple of days (it seems to take a
> couple of days between me pushing stuff out one evening to stuff
> appearing in -next because of the timezones and timing of sfr's pulls.)

Okay, I see it both in your tree and in linux-next now. Thanks!

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120919/bc3925c9/attachment.sig>
