From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 02 Oct 2017 16:03:55 +0200
Subject: [PATCH] arm64: defconfig: enable NAND on Armada 7K/8K SoCs
In-Reply-To: <20170927160259.6074-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 27 Sep 2017 18:02:59 +0200")
References: <20170927160259.6074-1-gregory.clement@free-electrons.com>
Message-ID: <87shf1myt0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., sept. 27 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> The PXA3xx NAND driver supports also the NAND controller found on the
> Armada 7K/8K SoCs, so enable it.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/arm64

Gregory

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8495b88a0966..c7fda967719b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -156,6 +156,7 @@ CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_DENALI_DT=y
> +CONFIG_MTD_NAND_PXA3xx=y
>  CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_NBD=m
> -- 
> 2.14.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
