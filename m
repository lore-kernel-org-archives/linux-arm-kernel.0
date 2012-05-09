From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 10:42:53 +0200
Subject: [PATCH 01/15] i2c/busses: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <4FA4C5EA.7030006@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-2-git-send-email-lee.jones@linaro.org>
 <201205042002.20943.arnd@arndb.de> <4FA4C5EA.7030006@linaro.org>
Message-ID: <CACRpkda6EvO5O+C86HUefEde3+9FEg2aLFUixr_yaiYXtPjmuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 5, 2012 at 8:17 AM, Lee Jones <lee.jones@linaro.org> wrote:

> I haven't tested it yet (it builds with no warnings/errors, but I
> haven't booted it), as I don't have my board immediately to hand,
> but does this kind of thing better suit what you're looking for?
>
> From: Lee Jones <lee.jones@linaro.org>
> Date: Tue, 17 Apr 2012 16:04:13 +0100
> Subject: [PATCH 01/15] i2c/busses: Add Device Tree support to the Nomadik I2C
> ?driver
>
> Here we move the i2c-nomadik's default settings into the driver
> rather than specifying them from platform code. At the time of
> this writing we only have one user, the u8500. As new users are
> added, it is expected that they will be Device Tree compliant.
> If this is the case, we will look up their initialisation values
> by compatible entry, then apply them forthwith.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Make sure you test it first though.

Yours,
Linus Walleij
