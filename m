From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 21 Nov 2013 10:24:56 -0500
Subject: [PATCH] ARM: mv78xx0: delete local <mach/gpio.h> header
In-Reply-To: <1385046390-13499-1-git-send-email-linus.walleij@linaro.org>
References: <1385046390-13499-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131121152456.GB29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 04:06:30PM +0100, Linus Walleij wrote:
> This header is not used by anything, and since the arch does
> not specify NEED_MACH_GPIO_H it is not included into
> <linux/gpio.h> either. Delete it.
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I'm seeking an ACK from one of the mv78xx0 maintainers to
> take this through the GPIO tree.
> ---
>  arch/arm/mach-mv78xx0/include/mach/gpio.h | 9 ---------
>  1 file changed, 9 deletions(-)
>  delete mode 100644 arch/arm/mach-mv78xx0/include/mach/gpio.h

Build-tested with mv78xx0_defconfig against today's Linus' HEAD.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
