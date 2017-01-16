From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jan 2017 15:37:09 +0100
Subject: [PATCHv3 8/8] ARM: configs: stm32: Add RTC support in STM32
 defconfig
In-Reply-To: <1483623809-29937-9-git-send-email-amelie.delaunay@st.com>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-9-git-send-email-amelie.delaunay@st.com>
Message-ID: <0e58dc4b-e7d7-e327-6f8d-35253216a496@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 01/05/2017 02:43 PM, Amelie Delaunay wrote:
> This patch adds STM32 RTC support in stm32_defconfig file.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  arch/arm/configs/stm32_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index be19e09..0acff9e 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -57,6 +57,8 @@ CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
>  CONFIG_LEDS_TRIGGERS=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_STM32=y
>  CONFIG_DMADEVICES=y
>  CONFIG_STM32_DMA=y
>  # CONFIG_FILE_LOCKING is not set
>
Applied on stm32-defconfig-for-v4.11

thanks
Alex
