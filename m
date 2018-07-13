From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 13 Jul 2018 11:29:30 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable STM32 DCMI media support
In-Reply-To: <1530781532-7125-1-git-send-email-hugues.fruchet@st.com>
References: <1530781532-7125-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <605b6b51-a17a-eda3-4767-67c175ddcde2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

On 07/05/2018 11:05 AM, Hugues Fruchet wrote:
> Enables support of STM32 DCMI V4L2 media driver.
> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 8f6be19..42ad73f76 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -578,6 +578,7 @@ CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
>   CONFIG_VIDEO_STI_BDISP=m
>   CONFIG_VIDEO_STI_HVA=m
>   CONFIG_VIDEO_STI_DELTA=m
> +CONFIG_VIDEO_STM32_DCMI=m
>   CONFIG_VIDEO_RENESAS_JPU=m
>   CONFIG_VIDEO_RENESAS_VSP1=m
>   CONFIG_V4L_TEST_DRIVERS=y
> 

Applied on stm32-next.

Thanks.
Alex
