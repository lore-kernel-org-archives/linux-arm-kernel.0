From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 11:44:35 +0200
Subject: [PATCH 2/2] irqchip: gic: remove reduntant gic_set_irqchip_flags
In-Reply-To: <1436971109-20189-2-git-send-email-sudeep.holla@arm.com>
References: <1436971109-20189-1-git-send-email-sudeep.holla@arm.com>
 <1436971109-20189-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <CACRpkdYBHQtFrC0AVk7Y3w40T9f2McBSgRn9LXSR8cwDLzkuTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 4:38 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> Now that the GIC chip implementation enables IRQCHIP_SKIP_SET_WAKE and
> IRQCHIP_MASK_ON_SUSPEND by default, the platforms requiring them need
> not override the irqchip flags as before.
>
> This patch removes all the users of gic_set_irqchip_flags and the
> function itself.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Works for me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
