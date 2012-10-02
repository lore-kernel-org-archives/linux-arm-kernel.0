From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Oct 2012 10:55:30 +0200
Subject: [PATCH 01/10] ARM: ux500: Move all Device Tree booting into
 cpu-db8500
In-Reply-To: <1349165603-24401-2-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
 <1349165603-24401-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbU-LyzHj9egNeGEaKShdT13QE3b4635tjEuPFfUOMCgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2012 at 10:13 AM, Lee Jones <lee.jones@linaro.org> wrote:

> To aid the kernel in its effort to move to DT only booting, we're
> transplanting all Device Tree related code to cpu-db8500 which will
> remain persistent throughout the transition. This change paths the
> way for complete removal of board-mop500, which will be done once
> the all DMA settings are moved into the respective DT source files.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
