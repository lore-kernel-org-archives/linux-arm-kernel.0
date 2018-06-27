From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 26 Jun 2018 17:47:22 -0700
Subject: [PATCH V5 5/5] ARM: dts: stm32: update iwdg with lsi clock name
 for stm32f429
In-Reply-To: <1529941383-8653-6-git-send-email-ludovic.Barre@st.com>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-6-git-send-email-ludovic.Barre@st.com>
Message-ID: <1f13d8f9-3459-c91c-6cb6-041504ac16e6@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2018 08:43 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch updates iwdg watchdog to use lsi clock name.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index ede77e0..39ea13a 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -310,6 +310,7 @@
>   			compatible = "st,stm32-iwdg";
>   			reg = <0x40003000 0x400>;
>   			clocks = <&clk_lsi>;
> +			clock-names = "lsi";
>   			status = "disabled";
>   		};
>   
> 
