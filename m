From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 30 Sep 2018 11:46:53 +0200
Subject: [PATCH] MAINTAINERS: Update clock binding entry for Actions Semi
 Owl SoCs
In-Reply-To: <20180929073244.7091-1-manivannan.sadhasivam@linaro.org>
References: <20180929073244.7091-1-manivannan.sadhasivam@linaro.org>
Message-ID: <3ac263b8-f40d-ec29-d16c-8eae3dcc8e1f@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.09.18 um 09:32 schrieb Manivannan Sadhasivam:
> commit d0e45d686a3e ("dt-bindings: clock: Add S700 support for Actions
> Semi Soc's")'
> 
> renamed the clock binding for Actions Semi Owl SoCs from
> actions,s900-cmu.txt to actions,owl-cmu.txt inorder to accommodate all
> members of Owl family SoCs. Hence, update the relevant entry in
> MAINTAINERS file.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fff353db7536..e9d6ce3243ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1191,7 +1191,7 @@ F:	drivers/soc/actions/
>  F:	include/dt-bindings/power/owl-*
>  F:	include/linux/soc/actions/
>  F:	Documentation/devicetree/bindings/arm/actions.txt
> -F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> +F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
>  F:	Documentation/devicetree/bindings/dma/owl-dma.txt
>  F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt

These two lines do not yet exist on v4.20/arm64 branch - rebased and
applied.

>  F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
