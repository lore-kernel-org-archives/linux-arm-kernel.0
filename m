From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Nov 2012 10:01:23 -0800
Subject: [PATCH] irq: versatile: delete dangling variable
In-Reply-To: <1354120850-15382-1-git-send-email-linus.walleij@stericsson.com>
References: <1354120850-15382-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121130180123.GB4505@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 05:40:50PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This one was just creating noise like this:
> 
> drivers/irqchip/irq-versatile-fpga.c: In function 'fpga_irq_of_init':
> drivers/irqchip/irq-versatile-fpga.c:180:24: warning: unused variable 'f'
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Arnd, Olof: please put this patch directly where the offending
> commit is. If I understand correctly that is on the branch
> integrator/irq.

Thanks, applied.

-Olof
