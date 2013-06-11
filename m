From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 11 Jun 2013 09:03:22 -0700
Subject: [PATCH] drivers: pinctrl: add active state to core
In-Reply-To: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
References: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130611160322.GB20352@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 10:16:56AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> In addition to the recently introduced pinctrl core
> control, the PM runtime pin control for the OMAP platforms
> require a fourth state in addtition to the default, idle and
> sleep states already handled by the core: an explicit "active"
> state. Let's introduce this to the core in addition to the
> other states already defined.
> 
> Cc: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Greg: need your ACK on this to merge it through the pinctrl
> tree.
> ---
>  drivers/base/pinctrl.c                |  8 +++++++-
>  drivers/pinctrl/core.c                | 15 +++++++++++++++

For anything that just touches drivers/base/pinctrl.c, you don't need my
ack, that's your code, you can do whatever you want with it :)

But here you go anyway:
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
