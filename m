From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Nov 2012 17:41:26 +0100
Subject: New warnings (irqchip move)
In-Reply-To: <20121124100113.GQ5764@n2100.arm.linux.org.uk>
References: <20121124100113.GQ5764@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZP1WwC3S24jinH65b4gr8mPyW_9rs195b=fN31UPYspg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2012 at 11:01 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> From the build system:
>
> drivers/irqchip/irq-versatile-fpga.c: In function 'fpga_irq_of_init':
> drivers/irqchip/irq-versatile-fpga.c:180:24: warning: unused variable 'f'

OK sent a fixup patch to the SoC folks, thanks Russell.

Yours,
Linus Walleij
