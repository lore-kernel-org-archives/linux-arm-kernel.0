From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Feb 2014 20:40:08 +0000
Subject: [PATCH] ARM: ux500: disable msp2 device tree node
In-Reply-To: <1391544372-16863-1-git-send-email-linus.walleij@linaro.org>
References: <1391544372-16863-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140204204008.GC5196@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Feb 2014, Linus Walleij wrote:

> Commit 70b41abc151f9
> "ARM: ux500: move MSP pin control to the device tree"
> accidentally activated MSP2, giving rise to a boot scroll
> scream as the kernel attempts to probe a driver for it and
> fails to obtain DMA channel 14.
> 
> Fix this up by marking the node disabled again.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/ste-href.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
