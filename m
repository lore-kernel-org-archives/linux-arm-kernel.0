From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 26 Jun 2018 17:46:50 -0700
Subject: [PATCH V5 4/5] ARM: dts: stm32: add iwdg2 support for
 stm32mp157c-ed1
In-Reply-To: <1529941383-8653-5-git-send-email-ludovic.Barre@st.com>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-5-git-send-email-ludovic.Barre@st.com>
Message-ID: <2c5091b6-bea7-827a-a37a-c679ecbfcc07@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2018 08:43 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch activates independent watchdog support for
> stm32mp157c board.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/stm32mp157c-ed1.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> index ae33653..8af263a 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> @@ -68,6 +68,11 @@
>   	status = "okay";
>   };
>   
> +&iwdg2 {
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
>   &uart4 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart4_pins_a>;
> 
