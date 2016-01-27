From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 15:02:18 +0100
Subject: [PATCH v2] pinctrl: rockchip: add support for the rk3399
In-Reply-To: <1452152498-21780-1-git-send-email-wdc@rock-chips.com>
References: <1451997055-47655-1-git-send-email-wdc@rock-chips.com>
 <1452152498-21780-1-git-send-email-wdc@rock-chips.com>
Message-ID: <CACRpkdb6Cooo-_eBKJn-SdFkGPg2hR9nud7Tq6aa+bmkDuOEmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 8:41 AM, David Wu <wdc@rock-chips.com> wrote:

> From: David Wu <david.wu@rock-chips.com>
>
> The pinctrl of rk3399 is much different from other's,
> especially the 3bits of drive strength.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
> change from v1:
> - need spin_unlock_irqrestore for set drive default case

Heiko can you please look at this patch?

> +       { .compatible = "rockchip,rk3399-pinctrl",
> +               .data = (void *)&rk3399_pin_ctrl },

I guess this requires a small patch to some binding file.
It's OK to fold that into this patch.

Yours,
Linus Walleij
