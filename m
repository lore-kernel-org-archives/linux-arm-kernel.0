From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Aug 2012 13:23:13 +0200
Subject: [PATCH 1/1] i2c: Add default configuration into the Nomadik I2C
 driver
In-Reply-To: <20120806102151.GB16996@gmail.com>
References: <1344243146-6598-1-git-send-email-linus.walleij@stericsson.com>
 <20120806102151.GB16996@gmail.com>
Message-ID: <CACRpkdZRCJXFGAVaD2eFWDhRX_=1G=MzDp=-PB6C3HKUpqkkWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 12:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> From: Lee Jones <lee.jones@linaro.org>
> Date: Mon, 6 Aug 2012 11:04:14 +0100
> Subject: [PATCH 1/1] i2c: Add default configuration into the Nomadik I2C
>  driver.
>
> At this moment in time there is only one known configuration for the
> Nomadik I2C driver. By not holding that configuration in the driver
> adds some unnecessary overhead in platform code. The configuration
> as already been removed from platform code, this patch checks for any
> over-riding configurations. If there aren't any, the default is used.
>
> Cc: linux-i2c at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Ah, I created my own solution for this as well by reverting back
some platform data.

This works too, but the patch does not apply to v3.6-rc1.
Please rebase and repost, then you can add my
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please not that you need to send I2C patches for embedded
to Wolfram Sang.

Wolfram, please pick this for the -rc series because it's a regression
in v3.6-rc1.

Yours,
Linus Walleij
