From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 18 Aug 2012 10:01:10 +0200
Subject: [PATCH 1/1 v4] i2c: Add default configuration into the Nomadik
 I2C driver.
In-Reply-To: <20120808131158.GD8227@gmail.com>
References: <1344266253-14050-1-git-send-email-lee.jones@linaro.org>
 <20120808131158.GD8227@gmail.com>
Message-ID: <20120818080110.GC24639@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 02:11:59PM +0100, Lee Jones wrote:
> From: Lee Jones <lee.jones@linaro.org>
> Date: Tue, 7 Aug 2012 12:27:24 +0100
> Subject: [PATCH 1/1 v4] i2c/nomadik: Add default configuration into the Nomadik I2C driver

Actually, unlike Linus said, I prefer "i2c: nomadik:"; minor nit,
though.

> 
> At this moment in time there is only one known configuration for the
> Nomadik I2C driver. By not holding that configuration in the driver
> adds some unnecessary overhead in platform code. The configuration
> as already been removed from platform code, this patch checks for any

  ^^ has ( I fixed it )

> over-riding configurations. If there aren't any, the default is used.
> 
> Cc: linux-i2c at vger.kernel.org
> Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to -current, thanks! I added a note from Linus that it is needed
because of boot regressions. That is also useful in commit messages.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120818/226190a7/attachment.sig>
