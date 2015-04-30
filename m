From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 30 Apr 2015 13:17:03 +0200
Subject: [STLinux Kernel] [PATCH v7 3/9] ARM: multi_v7_defconfig: Enable
 support for ST's LPC RTC
In-Reply-To: <1428590854-14095-4-git-send-email-lee.jones@linaro.org>
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
 <1428590854-14095-4-git-send-email-lee.jones@linaro.org>
Message-ID: <55420F2F.2040708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/09/2015 04:47 PM, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 138e68a..136b8da 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -490,6 +490,7 @@ CONFIG_RTC_DRV_MAX8907=y
>   CONFIG_RTC_DRV_MAX77686=y
>   CONFIG_RTC_DRV_RS5C372=m
>   CONFIG_RTC_DRV_PALMAS=y
> +CONFIG_RTC_DRV_ST_LPC=y
>   CONFIG_RTC_DRV_TWL4030=y
>   CONFIG_RTC_DRV_TPS6586X=y
>   CONFIG_RTC_DRV_TPS65910=y
Applied to sti_defconfig-for_v4.2.

Thanks!
Maxime
