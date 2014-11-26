From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Nov 2014 13:47:17 +0100
Subject: [PATCH v2] ARM: sa1100: improve irq handling
In-Reply-To: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
References: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdYQe8PKa0Cssns_yUGrG_snuJr6zbzc7HEpXiDMXZjKTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 8:09 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> This patch series makes sa1100 platform use MULTI_IRQ_HANDLER and irq
> domains to handle interrupts on StrongARM platform. Also virtual irq
> numbers are changed to start from 1 rather than 0. It doesn't change
> the way how Linux programs the hardware, only software interfaces are
> changed.
>
> Changes since v1:
> - Start IRQs from 1, freeing IRQ 0
> - Merge identical functions in the last patch
> - Other minor changes.

Applied all patches and tested on h3600 on top of v3.18-rc6.

Works like a charm.

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
