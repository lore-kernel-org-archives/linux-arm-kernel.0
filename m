From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Aug 2012 23:49:50 +0200
Subject: [PATCH 1/6] gpio/mxs: adopt irq_domain support for mxs gpio driver
In-Reply-To: <1345472400-31262-2-git-send-email-shawn.guo@linaro.org>
References: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
 <1345472400-31262-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdbSaa6ZOZYB1Cm7WjW0O51kvwsTAxhjefEKd-7XaBB3dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 4:19 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Remove irq_domain_add_legacy call from mach-mxs.c and have the gpio
> driver adopt irqdomain support, so that we can have the mapping
> between gpio and irq number available without using virtual_irq_start
> and MXS_GPIO_IRQ_START.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

OK patch applied, thanks!

Yours,
Linus Walleij
