From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Aug 2013 23:35:34 -0700
Subject: [GIT PULL] OMAPDSS: use new display drivers
In-Reply-To: <521EE98D.9070209@ti.com>
References: <521DAC2B.4080100@ti.com> <20130829061923.GM7656@atomide.com>
 <521EE98D.9070209@ti.com>
Message-ID: <20130829063534.GN7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130828 23:33]:
> On 29/08/13 09:19, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [130828 00:59]:
> >> Hi,
> >>
> >> Here's a pull request for the board file changes to take the new display
> >> drivers into use.
> > 
> > OK great.
> >  
> >> If there's an "early" pull request going to Linus during the merge window, it'd
> >> be nice to have these in that request. That would give me time to send a pull
> >> request to Linus containing removal of the old, no longer used, drivers.
> > 
> > Nice to see that this is not conflicting with anything in linux next :)
> 
> Did you add the series to your for-next branch?

No, I don't currently have for-next branch as it's done via arm-soc. But
I did a test merge with both linux next and arm-soc for-next branches
plus all the pending branches I have and did not see any conflicts.
 
> > I suggest you keep this branch immutable in case it need to be merged to arm-soc
> > tree, and merge it yourself along with the DSS patches. That way you
> 
> I do feel a bit uneasy with merging lots of arch changes via fbdev tree,
> but yes, I guess I can do that. Is that an "ack" from you for all the
> patches? If I do merge it via fbdev, I want to have at least acked-by in
> the commits. If that was an ack, I'll add them, but it means I need to
> update the branch.

I would not start messing with the patches at this point to add acks
as then your branch is no longer immutable. If you prefer, then it's
best that Kevin and Olof merge take this pull request directly.

> > don't have a dependency to arm-soc for removal of the old drivers.
> 
> The dependency is run-time dependency, so the removal series does not
> need to be based on this. As long as this series is merged first, things
> should work.

OK, that's good. The only issue is that we're pretty much out of time
right now for v3.12 merge window.

Regards,

Tony
