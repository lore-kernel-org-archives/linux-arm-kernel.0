From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 20 Mar 2017 10:45:04 +0000
Subject: [PATCH v6 2/4] dt-bindings: mfd: Add the description for LED as
 the sub module
In-Reply-To: <1489992447-13007-3-git-send-email-sean.wang@mediatek.com>
References: <1489992447-13007-1-git-send-email-sean.wang@mediatek.com>
 <1489992447-13007-3-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170320104504.mtefoscl355kgxlv@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Mar 2017, sean.wang at mediatek.com wrote:

> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch adds description for LED as the sub-module on MT6397/MT6323
> multifunction device.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index c568d52..522a3bb 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -6,6 +6,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
>  - Audio codec
>  - GPIO
>  - Clock
> +- LED
>  
>  It is interfaced to host controller using SPI interface by a proprietary hardware
>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
