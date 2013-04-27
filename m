From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 17:37:17 -0700
Subject: Exynos regressions w.r.t. config and debuggability due to
 multiplatform
In-Reply-To: <201304251931.25028.arnd@arndb.de>
References: <CAOesGMgRsa-AvbEZCc1=_ovaZMaG0S-CDok2MDp_zu5yderAYw@mail.gmail.com>
 <201304241703.49864.arnd@arndb.de> <51794CD3.4080807@samsung.com>
 <201304251931.25028.arnd@arndb.de>
Message-ID: <20130427003717.GC2350@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 07:31:24PM +0200, Arnd Bergmann wrote:
> On Thursday 25 April 2013, Kukjin Kim wrote:
> > 
> > On 04/25/13 00:03, Arnd Bergmann wrote:
> > > On Wednesday 24 April 2013, Olof Johansson wrote:
> > >> I think we should hold off on multiplatform for exynos until it works
> > >> better, i.e. 3.11.
> > >>
> > I think, this would be better choice for now if it's not urgent...
> > 
> 
> I spent a lot of time on it because it's a priority for Linaro, but
> that means I'm biased in the question of whether to merge it or not.
> It should only get in if you and Olof think it's a good idea.

I've reverted the commit you pointed out as the problematic one now,
and with that I get a working setup. That means most of the base patches are
in, just not the final Kconfig shuffling. 3.11 seems more realistic for that.


-Olof
