From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Apr 2017 14:13:48 +0100
Subject: [PATCH v2] drm: hdlcd: Fix the calculation of the scanout start
 address
In-Reply-To: <20170403103133.GL13355@e110455-lin.cambridge.arm.com>
References: <20170222153036.GI31595@intel.com>
 <20170308163025.31098-1-Liviu.Dudau@arm.com>
 <20170331094937.GO7909@n2100.armlinux.org.uk>
 <20170331131830.GK13355@e110455-lin.cambridge.arm.com>
 <20170331134810.GA25244@n2100.armlinux.org.uk>
 <20170403103133.GL13355@e110455-lin.cambridge.arm.com>
Message-ID: <20170403131348.GY7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:31:34AM +0100, Liviu Dudau wrote:
> On Fri, Mar 31, 2017 at 02:48:10PM +0100, Russell King - ARM Linux wrote:
> > I sent a reminder on 20th February about it, and we discussed it, and I
> > said at the time I did not have time to test your patch.  Ville commented
> > on your patch, which confused me a little, but having worked it out, I
> > reworked the patch from 21st November to fix that, creating this patch
> > series.
> > 
> > I did not post it, because I hadn't tested it (since the Juno requires
> > a long-winded way to update the kernel), so I never got around to
> > testing this.  So, this series pre-dates your v2 patch by a good few
> > weeks.
> 
> That information was privy to you and would've been nice to share with me.

So what the _hell_ do you think _this_ sentence means?  It _was_ shared
with you.

  The following series is what I came up with, although I've had no time
  to test it.

which was in the mail which was the parent to the series?  Does it
mean I'm bouncing a ball around the back yard maybe?

No, the information was there, you chose not to read it, and *you*
fucked up.  Notice that it is PAST TENSE, which means it HAPPENED IN
THE PAST.  NOT PRESENT.  This is basic english comprehension.

> > Now, due to the amount of patches I carry:
> > 
> > $ git lg origin.. | wc -l
> > 491
> > 
> > I work against Linus' tree _only_, so all patches I post are based on
> > Linus' kernel, and not random other git trees.  I do not randomly fetch
> > other git trees to base patches on them, because that would cause me
> > insane merging issues so that I can test half the stuff I'm carrying.
> 
> I understand (to the best of my abilities) your position and the fact that
> as a maintainer of a large subsystem you have a specific workflow that you
> don't want to polute with minor exceptions. I would also ask you to understand
> that not everyone works in the same way as you and that other maintainers
> and other subsystems have different workflows and requirements. Having my
> tree as part of the DRM subtree means that we work mostly on the recent
> Linus' -rc up until about -rc4 and the quickly switch to linux-next. So one
> way of approaching this is to drop the arch/arm frame of thought when
> contributing to other trees and adopt their workflow (you know, the "when
> in Rome, do what romans do" attitude). The other way is to go to different
> maintainers and ask for special status and tell them that their puny drivers
> and tree don't matter that much compared to your mighty workflow and they
> should all bend to your greatness (the "all your bases belong to us" mindset).

For christ sake, I sent the patches out because I thought it would be
useful to show what I had come up with, because I believed it to be of
use.

I won't make that mistake again, I'll just delete such work, because
it's obviously far too much hassle to work with other people, because
they don't READ.

> > Now, it's true that they're not against -rc, but are currently against
> > 4.10 - it seems that I missed rebasing _this_ particular branch to
> > 4.11-rc yet, although most of my other branches are.
> 
> And how would you have handled this situation? Another maintainer sending
> you a patchset based on an older tree that doesn't match your currently
> published one? Would you have gone to the trouble of rebasing their work,
> or ask them do get back to you with a better series?

If the other work is better, then I would have replaced what I had
already merged with the better version, or ask for an update against
the current version.

I doubt that I'm going to get any time what so ever to test either
version, so I'm going to delete my version and wait for your version
to trickle through - which I guess will be in about two months time,
after the next merge window.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
