From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 19 Dec 2010 23:38:22 +0100
Subject: [PATCH 5/9] ux500: remove build-time changing macros
In-Reply-To: <1291786681-8664-5-git-send-email-rabin.vincent@stericsson.com>
References: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
	<1291786681-8664-5-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <AANLkTi=mnfMcdFgZKY9SGgO3RicA53EQDy0EfGXwrB_c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

this and subsequent patches from Rabin require the GIC patches from
your tree. So if I try to prep platform cleanups on top of this I depend
on them...

Since I plan to issue a pull request for the ux500 platform what
would be the best way to get out of this?

I seem to remember you don't like to pull code based off your
internal branches.

I'm contemplating cherry-picking the GIC patches (and any deps)
from your tree, basing my pullable tag on that and letting git cope.

Sounds OK?

Yours,
Linus Walleij


2010/12/8 Rabin Vincent <rabin.vincent@stericsson.com>:

> To allow the possiblity of building U8500 and U5500 support in the same
> image.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>

Yours,
Linus Walleij
