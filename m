From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2012 11:36:51 +0200
Subject: [PATCH] mfd: ab8500: Make ab8500_irq_get_virq() static
In-Reply-To: <1345460017-404-1-git-send-email-lee.jones@linaro.org>
References: <1345460017-404-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZu5o9mzY7Foktu0cL5pp2o+CRfvkmGzQj+TQKAL8QfYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 12:53 PM, Lee Jones <lee.jones@linaro.org> wrote:

> MFD core now takes care of  HWIRQ <-> VIRQ mapping, so the helper
> ab8500_irq_get_virq() is no longer used by ab8500 subordinate devices
> to obtain a Linux wide Virtual IRQ. The AB8500 IRQ controller still
> uses it internally though, so we'll just hide it from the rest of the
> world by making it static instead.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Luv this patch, well done!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
