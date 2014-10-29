From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Oct 2014 11:14:46 +0100
Subject: [PATCH 2/3] irqchip: GIC: Add support for irq_{get,
 set}_irqchip_state
In-Reply-To: <1414232097-4328-3-git-send-email-marc.zyngier@arm.com>
References: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
 <1414232097-4328-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CACRpkdZJBWF=JPksecB4UNxcYtjhybAUprhWHkdHzMpb6gchJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 25, 2014 at 12:14 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Add the required hooks for the internal state of an interrupt
> to be exposed to other subsystems.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

(...)
> +static void gic_poke_irq(struct irq_data *d, u32 offset)
> +static int gic_peek_irq(struct irq_data *d, u32 offset)

Awesome terminology Marc, very CBM BASIC v2 :)

Yours,
Linus Walleij
