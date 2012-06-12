From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 12:08:38 +0100
Subject: [PATCH] pinctrl: nomadik: fix up typo
In-Reply-To: <1339498592-1435-1-git-send-email-linus.walleij@stericsson.com>
References: <1339498592-1435-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4FD72336.9040803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/12 11:56, Linus Walleij wrote:
> Commit a60b57eddaa8af6c02cf7bbeb58ebf82881f08ac
> "drivers/gpio: gpio-nomadik: Add support for irqdomains"
> changed GPIO offset calculations to have this form:
> (gpio % NMK_GPIO_PER_CHIP) except in this one place for
> setting sleep mode, where the conversion was all wrong, and
> instead mod:ing the GPIO with the IRQ base which does not
> make any sense.
>
> So fix this up so we can use sleepmode.
>
> Cc: Lee Jones<lee.jones@linaro.org>
> Signed-off-by: Linus Walleij<linus.walleij@stericsson.com>

Makes sense.

Reviewed-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
