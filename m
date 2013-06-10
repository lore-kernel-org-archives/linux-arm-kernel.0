From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 09:45:35 +0200
Subject: [PATCH] irqchip: Return -EPERM for reserved IRQs
In-Reply-To: <1370696686-1666-1-git-send-email-grant.likely@linaro.org>
References: <1370696686-1666-1-git-send-email-grant.likely@linaro.org>
Message-ID: <CACRpkdbGmOTL_Ks=n01TsoFPYn-GgwmJA5Yuch1g0wkEV=_=uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 8, 2013 at 3:04 PM, Grant Likely <grant.likely@linaro.org> wrote:

> The irqdomain core will report a log message for any attempted map call
> that fails unless the error code is -EPERM. This patch changes the
> Versatile irq controller drivers to use -EPERM because it is normal for
> a subset of the IRQ inputs to be marked as reserved on the various
> Versatile platforms.
>
> Signed-off-by: Grant Likely <grant.likely@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Looks good:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
