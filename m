From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 02 Sep 2014 11:18:34 -0700
Subject: [PATCH] ARM: ux500: disable msp2 node on Snowball
In-Reply-To: <1409661681-31490-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Tue, 2 Sep 2014 14:41:21 +0200")
References: <1409661681-31490-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <7h8um17uo5.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Analogous to commit 8858d88a25142544843869f0cd3e6654aa7b4aec
> that fixed commit 70b41abc151f9
> "ARM: ux500: move MSP pin control to the device tree"
> accidentally activated MSP2, giving rise to a boot scroll
> scream as the kernel attempts to probe a driver for it and
> fails to obtain DMA channel 14.
>
> For some reason I forgot to fix this on the Snowball. Fix
> this up by marking the node disabled again.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this patch directly to fixes for
> v3.17, I have no other pending Ux500 fixes.

Tested on snowball, and applied to fixes.

Thanks,

Kevin
