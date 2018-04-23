From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 23 Apr 2018 11:04:03 +0200
Subject: [PATCH v1 1/2] ARM: configs: stm32: Add MDMA support on
 STM32MP157C
In-Reply-To: <1524215707-14642-2-git-send-email-pierre-yves.mordret@st.com>
References: <1524215707-14642-1-git-send-email-pierre-yves.mordret@st.com>
 <1524215707-14642-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <48c7176a-a4a3-3f13-f76e-cd5833f7f8dc@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

On 04/20/2018 11:15 AM, Pierre-Yves MORDRET wrote:
> This patch adds MDMA support on STM32MP157C
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> ---
>   arch/arm/mach-stm32/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
> index 713c068..730feae 100644
> --- a/arch/arm/mach-stm32/Kconfig
> +++ b/arch/arm/mach-stm32/Kconfig
> @@ -46,6 +46,7 @@ if ARCH_MULTI_V7
>   
>   config MACH_STM32MP157
>   	bool "STMicroelectronics STM32MP157"
> +	select STM32_MDMA
>   	default y
>   
>   endif # ARMv7-A
> 

For patches located in mach-stm32, next time I prefer that you format 
commit header as following:

ARM: stm32: Add MDMA support on STM32MP157C

I don't see other issue, so don't resend for that, I will change it.

Regards
Alex
