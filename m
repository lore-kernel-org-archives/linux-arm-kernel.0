From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 12 Dec 2017 01:16:14 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_UNIPHIER_EFUSE
In-Reply-To: <1512005215-6323-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1512005215-6323-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <CAK7LNATznT8Es7gRVKO+xVCp7QLCRDo+gBbaW87cQpLSPSEiVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FW: Arnd and Olof,


This patch looks trivial enough.

The reason for not-apply is
probably because this patch was sent to Catalin and Will
without Arnd and Olof even CC'ed.



Arnd, Olof,
Please consider to apply it.

This one:
https://patchwork.kernel.org/patch/10084055/


Thanks.



2017-11-30 10:26 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> Enable the efuse driver for UniPhier SoC
>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6356c6d..41e1b56 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -558,6 +558,7 @@ CONFIG_PHY_XGENE=y
>  CONFIG_PHY_TEGRA_XUSB=y
>  CONFIG_QCOM_L2_PMU=y
>  CONFIG_QCOM_L3_PMU=y
> +CONFIG_UNIPHIER_EFUSE=y
>  CONFIG_TEE=y
>  CONFIG_OPTEE=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
