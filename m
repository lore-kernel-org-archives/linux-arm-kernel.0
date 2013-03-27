From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 13:54:03 +0100
Subject: [PATCH] mfd: ab8500-core: Ignore masked out interrupts
In-Reply-To: <1363873784-27378-1-git-send-email-fabio.baltieri@linaro.org>
References: <1363873784-27378-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdaAiWQ-j1jsPZzE+FxQU2fUhc1vqq+tp2fV8Tmf3sbR0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 2:49 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> AB8500 asserts LATCH bits for masked out interrupts.  This patch
> explicitly masks those out using the cached mask value to prevent
> handle_nested_irq() being called for masked IRQ on the same register as
> unmasked ones.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Sam, ping on this.

Yours,
Linus Walleij
