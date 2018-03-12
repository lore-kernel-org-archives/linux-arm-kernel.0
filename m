From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 12 Mar 2018 09:45:32 -0700
Subject: [PATCH] ARM: dts: msm8974: castor: Correct typo in touchscreen
 compatible string
In-Reply-To: <20180312160734.5606-1-ctatlor97@gmail.com>
References: <20180312160734.5606-1-ctatlor97@gmail.com>
Message-ID: <20180312164532.GA1016@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 12 Mar 09:07 PDT 2018, Craig Tatlor wrote:

> This was mistakenly pulled from the downstream tree.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Thanks Craig,

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> index e87f2c99060d..d85311a0422c 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> @@ -491,7 +491,7 @@
>  		pinctrl-0 = <&i2c8_pins>;
>  
>  		synaptics at 2c {
> -			compatible = "syna,rmi-i2c";
> +			compatible = "syna,rmi4-i2c";
>  			reg = <0x2c>;
>  
>  			interrupt-parent = <&msmgpio>;
> -- 
> 2.16.1
> 
