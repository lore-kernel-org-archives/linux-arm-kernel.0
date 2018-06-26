From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 26 Jun 2018 10:59:16 +0200
Subject: [PATCH v1] ARM: multi_v7_defconfig: enable STM32 DMAv2, DMAMUX
 and MDMA
In-Reply-To: <1527498513-19167-1-git-send-email-pierre-yves.mordret@st.com>
References: <1527498513-19167-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <7ecfa4af-5df0-7843-ae6c-0c5e34bdac2c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Pierre-Yves

On 05/28/2018 11:08 AM, Pierre-Yves MORDRET wrote:
> This enables drivers for STM32:
>   - DMAv2
>   - DMMAUX
>   - MDMA
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> ---
>   arch/arm/configs/multi_v7_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 89167cd..9f62957 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -887,6 +887,9 @@ CONFIG_QCOM_BAM_DMA=y
>   CONFIG_XILINX_DMA=y
>   CONFIG_DMA_SUN6I=y
>   CONFIG_ST_FDMA=m
> +CONFIG_STM32_DMA=y
> +CONFIG_STM32_DMAMUX=y
> +CONFIG_STM32_MDMA=y
>   CONFIG_STAGING=y
>   CONFIG_SENSORS_ISL29018=y
>   CONFIG_SENSORS_ISL29028=y
> 

Applied on stm32-next.

Thanks.
Alex
