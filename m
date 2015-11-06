From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 6 Nov 2015 13:40:30 +0900
Subject: [PATCH] arm64: defconfig: Enable samsung MFD and related configs
In-Reply-To: <1446784533-31911-1-git-send-email-alim.akhtar@samsung.com>
References: <1446784533-31911-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CAJKOXPd4BGaC24F852SpqrrFys8rSvw3OVPpNrrscqJ_pJawtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-06 13:35 GMT+09:00 Alim Akhtar <alim.akhtar@samsung.com>:
> This patch enables below configs by default:
>  * CONFIG_MFD_SEC_CORE
>  * CONFIG_REGULATOR_S2MPS11
>  * CONFIG_RTC_DRV_S5M

Instead of duplicating in the description the contents of the patch,
please describe why you want this and for which devices.

Best regards,
Krzysztof

>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/configs/defconfig |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 9492fe7edbbc..78e89e690dc1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -131,9 +131,11 @@ CONFIG_GPIO_XGENE=y
>  CONFIG_POWER_RESET_XGENE=y
>  CONFIG_POWER_RESET_SYSCON=y
>  # CONFIG_HWMON is not set
> +CONFIG_MFD_SEC_CORE=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_QCOM_SMD_RPM=y
> +CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_FB=y
>  CONFIG_FB_ARMCLCD=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> @@ -162,6 +164,7 @@ CONFIG_LEDS_TRIGGERS=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_LEDS_TRIGGER_CPU=y
>  CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_S5M=y
>  CONFIG_RTC_DRV_EFI=y
>  CONFIG_RTC_DRV_XGENE=y
>  CONFIG_DMADEVICES=y
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
