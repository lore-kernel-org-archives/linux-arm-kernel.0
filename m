From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Sep 2012 22:55:05 +0100
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <CACRpkdZhJyqeeXV_Zcfi7S01oH1Kw95qvAmOqrMKwhSLb-mX=Q@mail.gmail.com>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
 <201209011841.58977.arnd@arndb.de>
 <CACRpkdZhJyqeeXV_Zcfi7S01oH1Kw95qvAmOqrMKwhSLb-mX=Q@mail.gmail.com>
Message-ID: <20120903215505.GB31511@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 11:43:37PM +0200, Linus Walleij wrote:
> On Sat, Sep 1, 2012 at 8:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I think we discussed this before. It would be nice to replace the #if/#else
> > with
> >
> > #ifdef CONFIG_OF
> > ...
> > #endif
> > #ifdef CONFIG_ATAG
> > ...
> > #endif
> 
> Sure, have you applied Nico's patch adding CONFIG_ATAG to and
> ARM SoC branch so I can base my patches on it?
> 
> I was under the impression that his patch would go through Russell's
> tree and I would thus not be able to rely on it until it has landed there
> and you have pulled Russell's stuff into your tree.

One of them is already in my tree - I put it in on Saturday though on an
unstable branch.

> Currently I would make it impossible to use ATAGs if I do this since
> the symbol does not exist, so I really need to base such an
> approach in a tree which has CONFIG_ATAG in the first place.

I've just merged that patch though.
