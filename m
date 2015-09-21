From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 21 Sep 2015 09:26:09 +0300
Subject: [PATCH 10/14] ARM: dts: qs600: Add missing pinctrl property for
 gsbi7 uart
In-Reply-To: <1442579513-20356-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1442579513-20356-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55FFA301.80201@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/15 15:31, Srinivas Kandagatla wrote:
> This patch adds missing 2pin uart pinctrl property to gsbi7 uart on
> CM-QS600.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> index bdea747..8aac3be 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> @@ -101,6 +101,8 @@
>  			qcom,mode = <GSBI_PROT_I2C_UART>;
>  			serial at 16640000 {
>  				status = "ok";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&gsbi7_uart_2pins>;
>  			};
>  		};
>  
> 

-- 
Regards,
Igor.
