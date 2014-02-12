From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Feb 2014 16:03:56 +0100
Subject: [PATCH v4] gpio: davinci: reuse for keystone soc
In-Reply-To: <1391615244-12014-1-git-send-email-grygorii.strashko@ti.com>
References: <1391615244-12014-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CACRpkdbrs==tpUBs=WLWkt0frBcSMRDRokOn2tvP-1gt7Qq3+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 5, 2014 at 4:47 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> The similar GPIO HW block is used by keystone SoCs as
> in Davinci SoCs.
> Hence, reuse Davinci GPIO driver for Keystone taking into
> account that Keystone contains ARM GIC IRQ controller which
> is implemented using IRQ Chip.
>
> Documentation:
>         http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Changes in v4:
> - rebased on top of v3.14 +
>   [patch] gpio: davinci: signedness bug in davinci_gpio_irq_setup()

I tried applying this and it does not apply on the "devel" branch
in the GPIO tree. Since I haven't touched one line of code in the
DaVinci driver since v3.14-rc1 I seriously doubt that this is
rebased on v3.14[-rc].

Can you please rebase the patch onto v3.14-rc1 for real and
resend it?

Yours,
Linus Walleij
