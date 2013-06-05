From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 5 Jun 2013 11:54:05 -0700
Subject: [PATCH 1/3] drivers: pinctrl sleep and idle states in the core
In-Reply-To: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130605185405.GA18884@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 03:44:31PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> If a device have sleep and idle states in addition to the
> default state, look up these in the core and stash them in
> the pinctrl state container.
> 
> Add accessor functions for pinctrl consumers to put the pins
> into "default", "sleep" and "idle" states passing nothing but
> the struct device * affected.
> 
> Solution suggested by Kevin Hilman, Mark Brown and Dmitry
> Torokhov in response to a patch series from Hebbar
> Gururaja.
> 
> Cc: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I'm seeking Gregs ACK on this in the end, so we can take this
> in through the pinctrl tree. But first let's review!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
