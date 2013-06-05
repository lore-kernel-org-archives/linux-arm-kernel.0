From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 5 Jun 2013 11:54:21 -0700
Subject: [PATCH 2/3] tty: serial: modify PL011 driver to use pinctrl PM
 helpers
In-Reply-To: <1370439873-30053-2-git-send-email-linus.walleij@stericsson.com>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
 <1370439873-30053-2-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130605185421.GB18884@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 03:44:32PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This augments the PL011 UART driver to utilize the new pinctrl
> core PM helpers to transition the driver to default and sleep
> states, cutting away some boilerplate code.
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
> I'm seeking Greg's ACK on this as well so we can take the
> whole refactoring through the pinctrl tree.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
