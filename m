From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 17:48:57 -0700
Subject: [PATCH v3 1/9] gpiolib-of: Rename gpio_hog functions to be generic
In-Reply-To: <1439561466-14350-2-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkda+m9gy=fpigRfGnXBHgpjd71zLGyA0md0FsyXbMEaxaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 7:10 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> The gpio hogging functions are currently only used for gpio-hogging. But
> these functions are widely generic ones which parse gpio device nodes in
> the DT.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

This patch applied after a small rebasing.

BTW: at this point, please base your subsequent submissions on my
"devel" branch from linux-gpio as I am starting to apply some stuff.

Yours,
Linus Walleij
