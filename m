From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 21 Jul 2013 18:15:03 +0200
Subject: [PATCH 1/5] gpio: pxa: remove dead code
In-Reply-To: <1373555877-29887-2-git-send-email-zonque@gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
 <1373555877-29887-2-git-send-email-zonque@gmail.com>
Message-ID: <CACRpkdaB7JnWzoLKpQ1eLWAi7yFz9CanhbhwtiCnEtcNWzX3RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 5:17 PM, Daniel Mack <zonque@gmail.com> wrote:

> Commit f87311743 ("ARM: mmp: add more compatible names in gpio driver")
> changed the driver logic to determine the number of available GPIOs from
> the compatible string, and hence obsoleted the (undocumented) child
> nodes that were previously necessary. However, it left some remainder
> which can be safely removed now.
>
> Also, this patch makes pxa_gpio_probe_dt() return the correct value in
> case irq_alloc_descs() fails.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Tentatively applied, Haojian, does this look allright?

Yours,
Linus Walleij
