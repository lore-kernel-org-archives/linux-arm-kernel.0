From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 26 Jan 2017 18:37:16 +0900
Subject: [PATCH 1/2] arm64: defconfig: enable CONFIG_MTD_BLOCK
In-Reply-To: <1482249893-14988-1-git-send-email-yamada.masahiro@socionext.com>
References: <1482249893-14988-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQLeo_T5mPKffRXDRewZOrYijgSa4-Mjg_hiN64pLFZ1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

2016-12-21 1:04 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Enable the block layer support for MTD devices.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Please check this series, and pick it up for ASOC if it looks good.

Thanks,


>
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 869dded..32d73ab 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -143,6 +143,7 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_DMA_CMA=y
>  CONFIG_MTD=y
> +CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
