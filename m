From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Oct 2013 18:19:25 +0200
Subject: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask
 is changed
In-Reply-To: <1381507996-15021-1-git-send-email-rogerq@ti.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
Message-ID: <CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 6:13 PM, Roger Quadros <rogerq@ti.com> wrote:

> On OMAPs the IO ring must be rearmed each time the pad wakeup
> configuration is changed. So call pcs_soc->rearm() from
> pcs_irq_set().
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

If Tony needs to apply this with the other patches: Acked-by.

Yours,
Linus Walleij
