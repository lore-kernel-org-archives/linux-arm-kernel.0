From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 09:53:01 -0800
Subject: [GIT PULL] Integrator DTS and defconfig changes
In-Reply-To: <CACRpkdYoornJx1fTN1C5OiR16w9DbTcr9ze4gc9PLkt7LCqqCQ@mail.gmail.com>
References: <CACRpkdara5D=kvGVYu-WRh_JYK6Z9NKmQ-eniXsauxdzx-QJbA@mail.gmail.com>
 <20161118072506.GC1785@localhost>
 <CACRpkdYoornJx1fTN1C5OiR16w9DbTcr9ze4gc9PLkt7LCqqCQ@mail.gmail.com>
Message-ID: <20161118175301.GA8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 09:26:56AM +0100, Linus Walleij wrote:
> On Fri, Nov 18, 2016 at 8:25 AM, Olof Johansson <olof@lixom.net> wrote:
> 
> > I also sympathize that it's extra annoying having to split just three
> > patches across two branches. So, if it's easier we can just cherry-pick
> > apart the patches here across the branches (your comment about next
> > coverage makes me suspect you have no direct downstream users of this
> > branch). If that's OK, let me know and I'll do that tomorrow.
> 
> It's fine to cherry-pick, I can also send two separate branches (or
> just 2+1 stand-alone patches).
> 
> Any way you like it :) just tell me what to do, all I want is to get this
> in for v4.10.

Cherry-picking is actually faster on our side than merging, so I've done that
now. Queued into next/dt and next/defconfig for 4.10.


Thanks!


-Olof
