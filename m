From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 13:22:27 +0100
Subject: [PATCH 16/16] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <1353448867-15008-17-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-17-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdai62ox=fJ31viCOVfNc1skEEr+7356PEf0y1j6jzDrdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 11:01 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> This moves the Versatile FPGA interrupt controller driver, used in
> the Integrator/AP, Integrator/CP and some Versatile boards, out
> of arch/arm/plat-versatile and down to drivers/irqchip where we
> have consensus that such drivers belong. The header file is
> consequently moved to <linux/platform_data/irq-versatile-fpga.h>.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

It appears you have modified my commit so this is not the
whole story right?

This doesn't look like I wrote it:
+IRQCHIP_DECLARE(versatile_fpga_irq, "arm,versatile-fpga-irq",
+               fpga_irq_of_init);
+

Is it possible to do your changes on top of my commit
instead?

Atleast add your Signed-off-by please...

Yours,
Linus Walleij
