From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 25 Dec 2011 00:26:09 +0100
Subject: [PATCH v2] gpio: pl061: convert to use generic irq chip
In-Reply-To: <1324327927-6886-1-git-send-email-robherring2@gmail.com>
References: <1323876538-20406-8-git-send-email-robherring2@gmail.com>
 <1324327927-6886-1-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdY3=4b4P7N-oK1UyHbY-FEzm=nvaGzuD_28Mbof1msY2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 9:52 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Convert the pl061 irq_chip code to use the generic irq chip code.
>
> This has the side effect of using 32-bit accesses rather than 8-bit
> accesses to interrupt registers. The h/w TRM and testing seem to indicate
> this is fine.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.ml.walleij@gmail.com>
> ---
> v2:
> - put struct irq_chip_generic pointer into struct pl061_gpio instead of domain
> ptr.

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
