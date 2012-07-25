From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 16:17:20 +0000
Subject: [PATCH 1/2] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <1343230539-7196-1-git-send-email-zonque@gmail.com>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
Message-ID: <201207251617.21735.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Daniel Mack wrote:
> Simplify the code in gpio-pxa.c and make them based on irq_base.
> When not probed from devicetree, initialize irq_base from
> PXA_GPIO_TO_IRQ() or MMP_GPIO_TO_IRQ(), respectively, so the non-DT case
> still works.
> 
> Only tested on PXA3xx.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Both look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
