From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 May 2012 14:26:54 +0200
Subject: Handling of modular boards
In-Reply-To: <201205041934.08830.arnd@arndb.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
Message-ID: <CACRpkdb4LGXfJ72uODr841O7M4FGTYKa1X7y6ekeLUw9vaL=mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 9:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Thanks for getting the discussion started. I've seen the same issue come
> up for arch/arm/mach-ux500/board-mop500*uib.c and for the beaglebone.
> I'm sure there are many more, but we should make sure that everyone
> of these can live with whatever we come up with.

The same issue sort of comes up with any system that uses the idiom
to have a few GPIO lines indicate in a binary code what version of the
board we're dealing with and what devices are thus on it, right?

We have this issue for the U9540 reference design and potentially
on the Snowball as well.

Yours,
Linus Walleij
