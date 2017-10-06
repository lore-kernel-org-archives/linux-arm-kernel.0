From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 6 Oct 2017 15:01:50 +0200
Subject: [RESEND PATCH v5 4/4] ARM: configs: stm32: Add DMAMUX support in
 STM32 defconfig
In-Reply-To: <1506065492-31478-5-git-send-email-pierre-yves.mordret@st.com>
References: <1506065492-31478-1-git-send-email-pierre-yves.mordret@st.com>
 <1506065492-31478-5-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <5dfb2dc4-a286-b810-3707-82d39ab07ae5@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/22/2017 09:31 AM, Pierre-Yves MORDRET wrote:
> This patch adds DMAMUX support in STM32 defconfig file
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>      v5:
>      v4:
>      v3:
>      v2:
>          * None
> ---
> ---
>   arch/arm/configs/stm32_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index 90e5c46..988f395 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -67,6 +67,7 @@ CONFIG_RTC_CLASS=y
>   CONFIG_RTC_DRV_STM32=y
>   CONFIG_DMADEVICES=y
>   CONFIG_STM32_DMA=y
> +CONFIG_STM32_DMAMUX=y
>   CONFIG_IIO=y
>   CONFIG_STM32_ADC_CORE=y
>   CONFIG_STM32_ADC=y
> 

Applied on stm32-defconfig-for-v4.15 branch.

Thanks
Alex
