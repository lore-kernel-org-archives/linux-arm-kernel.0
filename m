From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 22:34:02 -0700
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <CACRpkdbXSaBNystUv9RTmDKrmV=OakFF49LPkoQtoi9FnaXmDg@mail.gmail.com>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
 <201209011841.58977.arnd@arndb.de>
 <CACRpkdZhJyqeeXV_Zcfi7S01oH1Kw95qvAmOqrMKwhSLb-mX=Q@mail.gmail.com>
 <20120903215505.GB31511@n2100.arm.linux.org.uk>
 <CACRpkdbXSaBNystUv9RTmDKrmV=OakFF49LPkoQtoi9FnaXmDg@mail.gmail.com>
Message-ID: <20120905053402.GI6747@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 09:19:10AM +0200, Linus Walleij wrote:
> On Mon, Sep 3, 2012 at 11:55 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > [Me]
> >> Currently I would make it impossible to use ATAGs if I do this since
> >> the symbol does not exist, so I really need to base such an
> >> approach in a tree which has CONFIG_ATAG in the first place.
> >
> > I've just merged that patch though.
> 
> OK great, Arnd do you have a Russell baseline in ARM SoC or is it
> easier if I try to submit this series directly to Russell?

Since Russell said he hasn't applied it to a stable branch we can't pull
anything in yet. But once he does, especially if he does it on a separate topic
branch, we can easily pull that in as a prerequisite in arm-soc. Russell?

There probably isn't much conflicting development in this release cycle
on integrator though, so having all changes go through Russell could be
OK as well. Only time that becomes awkward is if there's changes in both
trees that end up needing manual merge resolution. I don't think that's
high risk in this case.

So, Linus, it's up to you (and Russell) what you prefer, but I'd be
happy to take it through arm-soc if we get a stable base.


-Olof
