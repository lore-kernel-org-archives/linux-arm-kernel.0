From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Jul 2016 11:15:52 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Fixes for v4.8
In-Reply-To: <4175400.eEqji2rNII@wuerfel>
References: <cover.1468808109.git.horms+renesas@verge.net.au>
 <7322553.kXvQYPfzzh@wuerfel> <20160722015924.GH21943@verge.net.au>
 <4175400.eEqji2rNII@wuerfel>
Message-ID: <20160725021552.GJ12825@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 09:30:58PM +0200, Arnd Bergmann wrote:
> On Friday, July 22, 2016 10:59:24 AM CEST Simon Horman wrote:
> > On Thu, Jul 21, 2016 at 02:41:52PM +0200, Arnd Bergmann wrote:
> > > On Monday, July 18, 2016 11:39:35 AM CEST Simon Horman wrote:
> > > > Renesas ARM Based SoC DT Fixes for v4.8
> > > > 
> > > > * Corrections to r8a7792
> > > > 
> > > 
> > > Merged into next/dt, thanks!
> > 
> > Thanks!
> > 
> > I have queued up another fix for v4.8 since sending the above to you.
> > This time it is an SoC (C-code) rather than a DT fix. I am wondering
> > if you could offer guidance on:
> > 
> > * If you would prefer me to split fixes out into separate (DT, SoC, ...)
> >   branches? If so is that until around rc1 when everything has been
> >   merged into the forthcoming release and thereafter you would prefer
> >   a single fixes branch?
> 
> I prefer a separate fixes branch. It's fine for all other branches
> to be based on top of this branch so you have a working baseline
> for testing.

Is some sort of minimal base for the fixes branch desired?
If should the base be a merge of all the tags you have pulled for v4.8?

Currently I have DT fixes and SoC fixes which depend on
respective tags that have been accepted for v4.8.

> > * What pace you would like me to send fixes. I guess it depends on
> >   where we are in the cycle. Currently I put the changes in next and
> >   send what I have about once a week (or not if there are none :).
> > 
> > Typically there are very few fixes. But as I already have 3 for v4.8,
> > including those in this pull request, I get the feeling a few more could
> > emerge before v4.8 is released.
> 
> I'd say don't wait longer than a week before forwarding bugfixes.
> If you find something urgent, just send that right away along with
> whatever less urgent patches you have accumulated.
> 
> It's possible we won't merge it right away as we might all be busy
> for a couple of days, but in the worst case that means you send
> another fixes pull request that is a superset before we have merged
> the first one.
> 
> 	Arnd
> 
