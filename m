From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Jul 2016 17:29:05 +0200
Subject: [PATCH 0/3] ARM: fix three implicit module use cases fed via gpio
In-Reply-To: <20160720041332.30789-1-paul.gortmaker@windriver.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Message-ID: <CACRpkdbSGPfMTQs9pD+-eDMf7LjnWH1xcpsUcCbgLF5GxMK7Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 6:13 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> While working on some for-4.9 cleanups of linux/gpio/driver.h it was
> found that changes there caused build failures when walking all the
> ARM defconfigs, in ARM specific mach-* files.
(...)
> Paul Gortmaker (3):
>   ARM: mach-omap2: remove bogus "or_module" from rx51-peripherals
>   ARM: pxa: add module.h for corgi symbol_get/symbol_put usage
>   ARM: pxa: add module.h for spitz symbol_get/symbol_put usage

For all three:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
