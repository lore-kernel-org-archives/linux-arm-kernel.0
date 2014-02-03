From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Feb 2014 10:22:10 +0100
Subject: [PATCH 1/5] irqchip: vic: update the base IRQ member correctly
In-Reply-To: <1390397471-6802-2-git-send-email-linus.walleij@linaro.org>
References: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
 <1390397471-6802-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdY4TykG8du_Nf5pMYzZ_9u5XS9Zna6EfnWX-wKW0V_-xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 2:31 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> When passing 0 as the irq base the VIC driver will dynamically
> allocate a number of consecutive interrupt descriptors at some
> available number range. Make sure this number is recorded in
> the state container rather than the passed-in zero argument
> in this case.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> tglx: if you're happy with this pls ACK it so I can take this
> through the ARM SoC tree.

Ping on this.
Wanna queue up some stuff in ARM SoC.

Yours,
Linus Walleij
