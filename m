From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Sep 2013 13:13:41 +0100
Subject: [PATCH] ARM: sa1100: remove complex GPIO interface
In-Reply-To: <1380024219-21790-1-git-send-email-linus.walleij@linaro.org>
References: <1380024219-21790-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130924121340.GC12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 02:03:39PM +0200, Linus Walleij wrote:
> diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
> index 8ea3b33..5c94a53 100644
> --- a/drivers/gpio/gpio-sa1100.c
> +++ b/drivers/gpio/gpio-sa1100.c
> @@ -10,7 +10,7 @@
>  #include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> -
> +#include <asm/io.h>

How many more times does it need to be said...  I've been saying the same
thing for near on five years now and still this happens...
