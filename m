From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 08:42:57 +0200
Subject: [PATCH 2/9] ARM: export set_irq_flags
In-Reply-To: <1349796183-30648-3-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-3-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZ2h-V7c9EnQA6+m9sCaBD+tzU-sWrBLRtBTfgbeNWRXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 5:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The recently added Emma Mobile GPIO driver calls set_irq_flags
> and irq_set_chip_and_handler for the interrupts it exports and
> it can be built as a module, which currently fails with
>
> ERROR: "set_irq_flags" [drivers/gpio/gpio-em.ko] undefined!
>
> We either need to replace the call to set_irq_flags with something
> else or export that function. This patch does the latter.

Argh! And I cannot think of anything more elegant so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
