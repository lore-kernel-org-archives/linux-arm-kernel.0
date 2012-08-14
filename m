From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:17:08 +0200
Subject: [PATCH 1/8] of/irq: Create stub for of_irq_find_parent when
 !CONFIG_OF
In-Reply-To: <1344527635-6163-2-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb2MKgaoknHcWjrQqXPr6dXRsPjDxCwzNvGahJ48wMzdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:

> of_irq_find_parent is a handy function to use outside the confines of
> the Open Firmware subsystem. One such use-case is when the IRQ Domain
> wishes to find an IRQ domain for a given device node. Currently it can
> not take any notice of the 'interrupt-parent' property. Instead it
> just uses the first IRQ controller as it climbs the Device Tree. If
> we were to use this as a precursor the resultant controller is more
> likely to be correct.
>
> CC: Rob Herring <rob.herring@calxeda.com>
> CC: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This is clever.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
