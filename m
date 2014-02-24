From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 09:59:07 -0500
Subject: [PATCH 0/2] Marvell Armada 375 and 38x pinctrl drivers
In-Reply-To: <CACRpkdaR25oNOaZ0RYZWZOe-pjcv8esp-gg23QJXZ+nqASZzUA@mail.gmail.com>
References: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140217164406.17d3f59e@skate>
 <20140223211032.GR7862@titan.lakedaemon.net>
 <CACRpkdaR25oNOaZ0RYZWZOe-pjcv8esp-gg23QJXZ+nqASZzUA@mail.gmail.com>
Message-ID: <20140224145907.GC14250@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 11:25:58AM +0100, Linus Walleij wrote:
> On Sun, Feb 23, 2014 at 10:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > v4 of Sebastian's rework now depends on this series.
> 
> Yeah I figured so much :-)
> 
> >  As you've
> > expressed consent with Sebastian's series going through mvebu/arm-soc,
> > I'm going to go ahead and pull this into a topic branch as well.
> 
> I think it's better if I pull this massive set of pinctrl changes
> into the pinctrl tree, and then create an immutable branch for
> you to pull (and forward to ARM SoC).
> 
> > If you'd like the mvebu pinctrl branches to go through your tree, just
> > let me know and I'll send you a pull request for them.
> 
> That's better, so hit me with this!

Will do in a day or two (needs some -next time).  If you'd like to take
a look now, This series is in mvebu/pinctrl-3xx, based on v3.14-rc1.
Sebastian's series is in mvebu/pinctrl, also based on v3.14-rc1 and
depending on mvebu/pinctrl-3xx.

The tree is at git://git.infradead.org/linux-mvebu.git

> I'll dequeue the stuff I queued so far and wait for this.

Ok.

> The reason I want this in the pinctrl tree is that people
> tend to start sending small fixes on top and it creates
> a mess routing those patches. And it blocks us from
> major refactorings. So better keep it in my
> tree.

No problem.  Thanks for letting us work it this way.  The more testing
time we get before the merge window, the better.

thx,

Jason.
