From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 01:16:26 +0200
Subject: [PATCH 5/9] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
In-Reply-To: <20120831005230.28732.1131.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005230.28732.1131.stgit@muffinssi.local>
Message-ID: <CACRpkdZdvK+fB8rJFU6sLALjVx1SMBRH9pvg8shkmuzbZGt8xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 2:52 AM, Tony Lindgren <tony@atomide.com> wrote:

> We can't use hardcoded interrupts for SPARSE_IRQ, and can replace
> the hardcoded gpio_base with twl_gpiochip.base after it's been
> allocated.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Oh, cool.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
