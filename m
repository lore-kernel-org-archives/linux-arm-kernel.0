From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Jul 2015 14:48:00 +0100
Subject: [PATCH 1/2] MAINTAINERS: add Device Tree binding doc for
 max77686 regulator
In-Reply-To: <1437121078-26409-2-git-send-email-javier@osg.samsung.com>
References: <1437121078-26409-1-git-send-email-javier@osg.samsung.com>
 <1437121078-26409-2-git-send-email-javier@osg.samsung.com>
Message-ID: <20150723134800.GD3436@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015, Javier Martinez Canillas wrote:

> The Device Tree binding documentation for the Maxim max77686 regulators
> has been moved from the Multi-Function Device DT binding section to its
> own Documentation/devicetree/bindings/regulator/max77686.txt file.
> 
> Use a wilcard so both the mfd and regulator DT bindings are resolved.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2af741410533..d802d19a4ecc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6583,7 +6583,7 @@ F:	drivers/extcon/extcon-max77693.c
>  F:	drivers/rtc/rtc-max77686.c
>  F:	drivers/clk/clk-max77686.c
>  F:	Documentation/devicetree/bindings/mfd/max14577.txt
> -F:	Documentation/devicetree/bindings/mfd/max77686.txt
> +F:	Documentation/devicetree/bindings/*/max77686.txt
>  F:	Documentation/devicetree/bindings/mfd/max77693.txt
>  F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
>  F:	include/linux/mfd/max14577*.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
