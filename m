From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Feb 2014 10:23:04 +0100
Subject: [PATCH 2/5] irqchip: support cascaded VICs
In-Reply-To: <1390397471-6802-3-git-send-email-linus.walleij@linaro.org>
References: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
 <1390397471-6802-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZGvE5M+uJxQnq3fS=4iVi2KK7NXZgSAL-BFdoXEk3YSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 2:31 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds support for a VIC to be cascaded off another IRQ.
> On the Integrator/AP logical module IM-PD1 there is a VIC
> cascaded off the central FPGA IRQ controller so this is
> needed for that to work out.
>
> In order for the plug-in board to be able to register all
> the devices with their IRQs relative to the offset of the
> base obtained for the cascaded VIC, the base IRQ number
> is passed back to the caller.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> tglx: if you're happy with this pls ACK it so I can take this
> through the ARM SoC tree.

Ping on this, too.

Yours,
Linus Walleij
