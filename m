From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 13 May 2012 01:49:27 +0200
Subject: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
In-Reply-To: <4FABF553.20601@wwwdotorg.org>
References: <20120503065131.GA3738@game.jcrosoft.org>
 <20120503152708.GC5140@atomide.com>
 <4FA30805.5050804@wwwdotorg.org>
 <20120504044305.GD7788@game.jcrosoft.org>
 <20120504150342.GI5140@atomide.com>
 <20120504153251.GE7788@game.jcrosoft.org>
 <20120504163420.GA5613@atomide.com>
 <4FA42631.6060304@wwwdotorg.org>
 <20120504220809.GW5613@atomide.com>
 <4FAAD141.3090306@wwwdotorg.org>
 <20120509204925.GV5088@atomide.com> <4FABF553.20601@wwwdotorg.org>
Message-ID: <CACRpkdbqjofEi-5J+GTMOXFK1VvbXqa6At1fKXCge+5_y6aaRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 7:05 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> Also, were you intending pinctrl-simple to actually be the GPIO
> controller itself? That'd be another case that one might consider fairly
> simple, but then extends to being gpio-simple as well as pinctrl-simple...

We have some pinctrl drivers implementing gpiolib too already,
and it's unavoidable I think, as some recent discussion about
matcing struct gpio_chip and pinctrl GPIO ranges shows.

Maybe "-simple" isn't such a good name for this thing. Noone thinks
any kind of pin control is simple in any sense of the word anyway :-D

Tony, would pinctrl-dt-only.c be a better name perhaps?

Yours,
Linus Walleij
