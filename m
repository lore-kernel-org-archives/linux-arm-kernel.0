From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jul 2017 16:13:10 +0200
Subject: [PATCH] pinctrl: sunxi: rename R_PIO i2c pin function name
In-Reply-To: <20170730053618.44781-1-icenowy@aosc.io>
References: <20170730053618.44781-1-icenowy@aosc.io>
Message-ID: <CACRpkdb6woruLQPOfb2AGwraux5CienovZnJMox7VCh16JMXrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 30, 2017 at 7:36 AM, Icenowy Zheng <icenowy@aosc.io> wrote:

> The I2C pin functions in R_PIO used to be named "s_twi".
>
> As we usually use the name "i2c" instead of "twi" in the mainline
> kernel, change these names to "s_i2c" for consistency.
>
> The "s_twi" functions are not yet referenced by any device trees in
> mainline kernel so I think it's safe to change the name.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Patch applied with Chen-Yu's review tag.

Yours,
Linus Walleij
