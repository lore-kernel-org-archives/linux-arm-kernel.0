From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Feb 2011 17:17:24 -0000
Subject: [PATCH] nmk-gpio: use request_irq instead of chained handler
In-Reply-To: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>
References: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <002001cbd37d$8a39fd20$9eadf760$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin,

> __nmk_gpio_irq_handler doesn't do anything more that what a normal handler
> does, so it can become one.  This is also needed for changing the GIC
> implementation to a different flow handler.
> 
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>

mach-nomadik only seems to use the vic. Why does this GPIO handler
need updating?

Will
