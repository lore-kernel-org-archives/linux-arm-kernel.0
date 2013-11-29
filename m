From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 10:23:09 +0100
Subject: [PATCH v6 2/6] This patch converts the davinci gpio driver to use
 irqdomain support.
In-Reply-To: <1385057731-4348-3-git-send-email-prabhakar.csengg@gmail.com>
References: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>
 <1385057731-4348-3-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <CACRpkdYSQ-+hXRC0qvDAZU09QtzEUamR61myT9itoRe1W=BgvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 7:15 PM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:

> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> [grygorii.strashko at ti.com:
>  - switch to use one irq-domain per  all GPIO banks
>  - keep irq_create_mapping() call in gpio_to_irq_banked() as it
>    simply transformed to irq_find_mapping() if IRQ mapping exist
>    already]
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
