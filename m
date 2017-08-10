From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 19:50:25 +0900
Subject: [PATCH v2] arm64: defconfig: enable CONFIG_UNIPHIER_WATCHDOG
In-Reply-To: <1500359890-30358-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1500359890-30358-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <CAK7LNAST_ZcicTtEj21qjmbGhxXUs6VKqmV7-mgg7w9Btsb=3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forwarding to ARM-SOC


Hi Arnd, Olof,


This patch was sent to arm64 maintainers a few weeks ago
(but not picked up).

I think the best home for this patch is the ARM-SOC tree.

Could you pick it up, please?

This patch:
https://patchwork.kernel.org/patch/9847049/


Thanks,
Masahiro



2017-07-18 15:38 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> Enable the watchdog driver for UniPhier SoC
>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6c7d147..629c815 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -311,6 +311,7 @@ CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_MESON_GXBB_WATCHDOG=m
>  CONFIG_MESON_WATCHDOG=m
>  CONFIG_RENESAS_WDT=y
> +CONFIG_UNIPHIER_WATCHDOG=y
>  CONFIG_BCM2835_WDT=y
>  CONFIG_MFD_CROS_EC=y
>  CONFIG_MFD_CROS_EC_I2C=y
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
