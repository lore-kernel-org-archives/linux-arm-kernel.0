From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jul 2012 00:15:14 +0200
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
In-Reply-To: <201207161340.18528.arnd@arndb.de>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
 <20120716081703.GH21635@b20223-02.ap.freescale.net>
 <201207161340.18528.arnd@arndb.de>
Message-ID: <CACRpkdbCra8C=32wdpqyf9e05AsBDeiADiDn_FesvvW9bteVcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 3:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> One thing I've thought about
> before is to create some kind of very simple "system controller"
> framework based on regmap that lets you register a single global
> "struct regmap" pointer from an SoC specific driver, and have drivers
> call a function into that framework to get a reference to that
> regmap.

This sounds like a good idea. "misc-bit-poking" is something a lot
of systems are doing.

I haven't fully grasped regmap so that I can say whether that is the
proper abstraction or not though. But I trust you on this...

Yours,
Linus Walleij
