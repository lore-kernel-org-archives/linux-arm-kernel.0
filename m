From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Aug 2014 22:17:40 +0200
Subject: [PATCH linux-next] irq: export handle_fasteoi_irq
In-Reply-To: <1408663880-29179-1-git-send-email-vincent.stehle@laposte.net>
References: <1408663880-29179-1-git-send-email-vincent.stehle@laposte.net>
Message-ID: <4865705.6YRejgXUhp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 August 2014 01:31:20 Vincent Stehl? wrote:
> Export handle_fasteoi_irq to be able to use it in e.g. the Zynq gpio driver
> since commit 6dd859508336 ("gpio: zynq: Fix IRQ handlers").
> 
> This fixes the following link issue:
> 
>   ERROR: "handle_fasteoi_irq" [drivers/gpio/gpio-zynq.ko] undefined!
> 
> Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I saw the same thing here and came up with the same fix.
