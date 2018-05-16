From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 16 May 2018 09:38:45 +0200
Subject: [PATCH] MAINTAINERS: Add entry for STM32 timer and lptimer drivers
In-Reply-To: <1526398399-31753-1-git-send-email-fabrice.gasnier@st.com>
References: <1526398399-31753-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <c2539e10-81c1-d5e9-c284-14d5142e1a2a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice

On 05/15/2018 05:33 PM, Fabrice Gasnier wrote:
> Add an entry to make myself a maintainer of STM32 timer and lptimer
> drivers.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b65225..94d8e47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13425,6 +13425,16 @@ T:	git git://linuxtv.org/media_tree.git
>   S:	Maintained
>   F:	drivers/media/usb/stk1160/
>   
> +STM32 TIMER/LPTIMER DRIVERS
> +M:	Fabrice Gasnier <fabrice.gasnier@st.com>
> +S:	Maintained
> +F:	drivers/*/stm32-*timer*
> +F:	drivers/pwm/pwm-stm32*
> +F:	include/linux/*/stm32-*tim*
> +F:	Documentation/ABI/testing/*timer-stm32
> +F:	Documentation/devicetree/bindings/*/stm32-*timer
> +F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
> +
>   STMMAC ETHERNET DRIVER
>   M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
>   M:	Alexandre Torgue <alexandre.torgue@st.com>
> 

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
