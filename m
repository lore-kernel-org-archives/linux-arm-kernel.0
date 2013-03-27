From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 14:18:01 +0100
Subject: [PATCH 3/5] ARM: ux500: Remove platform specific PRCMU and Clk
 initialisation
In-Reply-To: <1363966065-2478-3-git-send-email-lee.jones@linaro.org>
References: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
 <1363966065-2478-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY-NCVekZ+jr4ZwxHHXuSrYbn-8j7p0OSaPbydO5jBR7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 4:27 PM, Lee Jones <lee.jones@linaro.org> wrote:

> For the moment at least, every platform which executes though
> ux500_init_irq requires the same clk and prcmu initialisation.
> So let's call those functions without clause.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This is not true after the multiplatform series so won't work, sorry!

Yours,
Linus Walleij
