From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 19 Nov 2016 12:21:55 +0000
Subject: [PATCH v3 4/6] ARM: configs: stm32: enable ADC driver
In-Reply-To: <1479223861-21747-5-git-send-email-fabrice.gasnier@st.com>
References: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
 <1479223861-21747-5-git-send-email-fabrice.gasnier@st.com>
Message-ID: <3f6d8fdd-31ed-06a1-22c0-ce6f06dead81@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/16 15:30, Fabrice Gasnier wrote:
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
The driver is now on it's way in.  I'm assuming this and the two device tree patches
will go via the relevant route to arm-soc.

Thanks,

Jonathan
> ---
>  arch/arm/configs/stm32_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index 1e5ec2a..5d241e0 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -57,6 +57,9 @@ CONFIG_LEDS_TRIGGERS=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_DMADEVICES=y
>  CONFIG_STM32_DMA=y
> +CONFIG_IIO=y
> +CONFIG_STM32_ADC_CORE=y
> +CONFIG_STM32_ADC=y
>  # CONFIG_FILE_LOCKING is not set
>  # CONFIG_DNOTIFY is not set
>  # CONFIG_INOTIFY_USER is not set
> 
