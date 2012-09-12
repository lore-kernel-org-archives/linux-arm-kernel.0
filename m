From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 23:05:32 +0200
Subject: [PATCH v2 6/6] ARM: make mach/gpio.h headers optional
In-Reply-To: <1346960563-18689-7-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <1346960563-18689-7-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdb3HtNg8BzpBMmdY=GJSNh=YCZ0DxggUgbnd7-ax=EuMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 9:42 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Most platforms don't need mach/gpio.h and it prevents multi-platform
> kernel images. Add CONFIG_NEED_MACH_GPIO_H and make platforns select it
> if they need gpio.h. This is platforms that define __GPIOLIB_COMPLEX
> or have lots of implicit includes pulled in by mach/gpio.h.
>
> at91 and omap have gpio clean-up pending and can drop
> CONFIG_NEED_MACH_GPIO_H once that is in.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Didn't I ACK this before? Oh well.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
