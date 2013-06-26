From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 26 Jun 2013 22:00:08 +0800
Subject: [PATCH] i.MX dts updates
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130626140007.GC21845@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 03:51:44PM +0200, Sascha Hauer wrote:
> This series contains several dts updates to i.MX SoCs.
> 
> - Add iim nodes to the dts files. We do not have a driver for the
>   iim in Linux, but barebox needs these
> - add aliases for i2c/spi consitently. We have started it, so let's
>   complete it.
> - sync pinmux between i.MX6Q and i.MX6DL. These really should be kept
>   in sync
> - some minor cleanup stuff and additions

Nice changes!  Applied the whole series, thanks.

Shawn
