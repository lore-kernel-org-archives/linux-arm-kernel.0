From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 16 Feb 2016 11:51:44 +0100
Subject: [PATCH 08/13] ARM: mvebu: enable SRAM support in
 mvebu_v7_defconfig
In-Reply-To: <1448178839-3541-9-git-send-email-mw@semihalf.com> (Marcin
 Wojtas's message of "Sun, 22 Nov 2015 08:53:54 +0100")
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <1448178839-3541-9-git-send-email-mw@semihalf.com>
Message-ID: <874md9udvj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On dim., nov. 22 2015, Marcin Wojtas <mw@semihalf.com> wrote:

As this config will be needed in any case, I have applied on
mvebu/defconfig. I also added a commit log.

Thanks,

Gregory

> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index c6729bf..fe57e20 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -58,6 +58,7 @@ CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_PXA3xx=y
>  CONFIG_MTD_SPI_NOR=y
> +CONFIG_SRAM=y
>  CONFIG_EEPROM_AT24=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_ATA=y
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
