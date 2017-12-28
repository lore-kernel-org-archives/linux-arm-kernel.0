From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Dec 2017 15:06:28 +0100
Subject: [PATCH] pinctrl: sunxi: fix a typo when merging A20 support to
 A10 driver
In-Reply-To: <20171228132009.12839-1-icenowy@aosc.io>
References: <20171228132009.12839-1-icenowy@aosc.io>
Message-ID: <CACRpkdYKrL+eBB4AdvRcqRTvejLqAK9hBpFwkdO7YNmiTpJ4ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 2:20 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> When merging A20 pinctrl support to A10 pinctrl driver, the I2C function
> of PI3 is wrongly written as "i2c3" (it should be "i2c4").
>
> Fix this typo.
>
> Fixes: cad4e209c102 ("pinctrl: sunxi: add support of R40 to A10 pinctrl driver")
> Reported-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Patch applied.

Yours,
Linus Walleij
