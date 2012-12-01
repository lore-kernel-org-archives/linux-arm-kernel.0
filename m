From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Dec 2012 19:11:11 +0100
Subject: [PATCH 1/6] ux500: convert struct spinlock to spinlock_t
In-Reply-To: <1354221910-22493-2-git-send-email-mcgrof@do-not-panic.com>
References: <1354221910-22493-1-git-send-email-mcgrof@do-not-panic.com>
 <1354221910-22493-2-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <CACRpkdYD=h9YL=GrwuQvBzjpek08MvumCnhX3SiXow63nLLP1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 9:45 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:

> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>
> spinlock_t should always be used.
>
> I was unable to build test with allmodconfig:
>
> mcgrof at frijol ~/linux-next (git::(no branch))$ make C=1 M=drivers/crypto/ux500/
>
>   WARNING: Symbol version dump /home/mcgrof/linux-next/Module.symvers
>            is missing; modules will have no dependencies and modversions.
>
>   LD      drivers/crypto/ux500/built-in.o
>   Building modules, stage 2.
>   MODPOST 0 modules
>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>

Looks correct to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
