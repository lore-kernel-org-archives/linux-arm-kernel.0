From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 3 May 2018 17:38:29 +0200
Subject: [RESEND PATCH 3/3] ARM: dts: stm32: update pwm-cells for LPTimer
 on stm32h743
In-Reply-To: <1519392965-28235-4-git-send-email-fabrice.gasnier@st.com>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
 <1519392965-28235-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <e531b9d2-e2d3-aedb-b388-ab639d0530d8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice

On 02/23/2018 02:36 PM, Fabrice Gasnier wrote:
> LPTimer pwm cells should be updated to 3, to allow initialization of
> channel, period and polarity.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---


Applied on stm32-next.

Thanks.
Alex


>   arch/arm/boot/dts/stm32h743.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index bbfcbac..40d7d76 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -85,6 +85,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   
> @@ -238,6 +239,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   
> @@ -264,6 +266,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   
> @@ -285,6 +288,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   		};
> @@ -300,6 +304,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   		};
> 
