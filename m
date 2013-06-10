From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 14:52:13 +0200
Subject: [PATCH 0/2] pinctrl: common handling of generic pinconfig props
 in dt
In-Reply-To: <201306090159.05383.heiko@sntech.de>
References: <201306090159.05383.heiko@sntech.de>
Message-ID: <CACRpkdaV0ipY4mYHt998D=NNKrpDaFhCA949V0-93NkOKcvHyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 1:59 AM, Heiko St?bner <heiko@sntech.de> wrote:

> following your suggestions for a common handling of things like pulls in dt,
> I've come up with the following solution - hopefully I've gotten the correct
> meaning of your explanaitions.
>
> It handles all the pinconfigs that either ignore the argument, or have very
> simple one, like PIN_CONFIG_OUTPUT does.

OK patches applied. It needs some rough fixes like NULL check
on kmalloc() but it'll do for a starter. Now I can tell everyone to
use this and refer to it.

> I've also attached my current rockchip pinctrl driver to show how it is using
> this currently.

OK I might just merge it. If you take the rest of the patches through
ARM SoC they will need to pull in my tree anyway if it's intended to
go in this merge window.

Yours,
Linus Walleij
