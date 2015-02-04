From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Feb 2015 13:19:30 +0100
Subject: [PATCH v2 0/5] ARM: sa1100: implement irq driver as proper
 irqchip driver
In-Reply-To: <1422648066-7897-1-git-send-email-dbaryshkov@gmail.com>
References: <1422648066-7897-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdbstAkL0Tyt6UHrzwkccMteOehoPwGROJxoUbpDJ1yxjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 9:01 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Hello,
>
> This is a second attempt to move Intel StrongARM SA-11x0 IRQ driver
> to drivers/irqchip/ place.
>
> Changes since V1:
>
>  - Added soc/sa1100/pwer.h header containing sa11x0_*_set_wake()
>    prototypes.
>
>  - Removed spinlock from mask/unmask functions
>
>  - Minor whitespace changes.
>
> The patches are based on my previous sa1100 patches that can be found
> in Russell's for-next branch or in linux-next tree.

I have applied it and tested on the Compaq iPaq h3600:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Very nice to see the SC and GPIO offsets in /proc/interrupts
and very clean code, good work!

Yours,
Linus Walleij
