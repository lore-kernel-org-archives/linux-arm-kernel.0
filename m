From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 15:00:41 +0200
Subject: [EXAMPLE PATCH] pinctrl: add pinctrl driver for Rockchip SoCs
In-Reply-To: <201306090201.17739.heiko@sntech.de>
References: <201306090159.05383.heiko@sntech.de>
 <201306090201.17739.heiko@sntech.de>
Message-ID: <CACRpkdaEcZZ3NZzwKOhUPjvFg+bSZ=UbpyPT2EBcAfVv1-EsKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 2:01 AM, Heiko St?bner <heiko@sntech.de> wrote:

(...)
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/clk-provider.h>
> +#include <dt-bindings/pinctrl/rockchip.h>

Hm I don't know if we're supposed to do things like this actually.

It depends on whether the <dt-bindings/*> hierarchy is supposed
to stay in the kernel after the device trees are moved out to a
separate repo.

Grant/Rob, shall we do this in drivers?

Yours,
Linus Walleij
