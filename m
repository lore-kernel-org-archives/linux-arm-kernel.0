From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 11:25:58 +0100
Subject: [PATCH 0/2] Marvell Armada 375 and 38x pinctrl drivers
In-Reply-To: <20140223211032.GR7862@titan.lakedaemon.net>
References: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140217164406.17d3f59e@skate>
 <20140223211032.GR7862@titan.lakedaemon.net>
Message-ID: <CACRpkdaR25oNOaZ0RYZWZOe-pjcv8esp-gg23QJXZ+nqASZzUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 10:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:

> v4 of Sebastian's rework now depends on this series.

Yeah I figured so much :-)

>  As you've
> expressed consent with Sebastian's series going through mvebu/arm-soc,
> I'm going to go ahead and pull this into a topic branch as well.

I think it's better if I pull this massive set of pinctrl changes
into the pinctrl tree, and then create an immutable branch for
you to pull (and forward to ARM SoC).

> If you'd like the mvebu pinctrl branches to go through your tree, just
> let me know and I'll send you a pull request for them.

That's better, so hit me with this!

I'll dequeue the stuff I queued so far and wait for this.

The reason I want this in the pinctrl tree is that people
tend to start sending small fixes on top and it creates
a mess routing those patches. And it blocks us from
major refactorings. So better keep it in my
tree.

Yours,
Linus Walleij
