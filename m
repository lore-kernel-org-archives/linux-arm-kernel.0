From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 12 Feb 2011 00:23:37 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102091013.56670.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
	<201102091013.56670.arnd@arndb.de>
Message-ID: <AANLkTimZb-hxz-31nGmycdtU-i=t=9wBoDJ-chAXUmD6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/9 Arnd Bergmann <arnd@arndb.de>:

> Most of my results so far are documented on
> https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashCardSurvey

H'm! That's an interesting resource indeed. When you write
"From measurements, it appears that the size in which data is
managed is typically 64 kb on SD cards" and "the size of the
medium is always a multiple of entire allocation groups, and
the most common size today is 4 MB" and then list
Size, Allocation Unit, Write Size, Page Size, FAT Location,
open AUs linear, open AUs random, Algorithm.

How exactly do you measure that?

I'm sort of smelling a card-probe.git with this tool that you
can run on your device and get out data like that listed
in your table. We have a rather large stash of cards we can
probe for you to get that kind of data out if it is useful, and
I believe other Linaro members may have such stuff too,
if empirical data is usefult to your work.

Yours,
Linus Walleij
