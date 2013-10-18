From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Oct 2013 11:55:37 +0100
Subject: [PATCH 5/5] ARM: ux500: register all SSP and SPI blocks
In-Reply-To: <1382087134-31740-1-git-send-email-linus.walleij@linaro.org>
References: <1382087134-31740-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131018105537.GU19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Linus Walleij wrote:

> This adds the SSP and SPI blocks to the device tree and makes
> them active. Only this way can their clocks be properly gated
> off at boot.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/ste-dbx5x0.dtsi | 75 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi

I assume you've tested this and it all works fine.

Code looks good to me: Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
