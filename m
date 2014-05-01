From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 1 May 2014 10:16:05 -0400
Subject: [PATCH v2 03/12] ARM: keystone: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <1398925607-7482-4-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
 <1398925607-7482-4-git-send-email-computersforpeace@gmail.com>
Message-ID: <53625725.6060401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 May 2014 02:26 AM, Brian Norris wrote:
> This defconfig contains the CONFIG_M25P80 symbol, which is now
> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to satisfy
> the new dependency.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
I will pick this up for 3.16.

>  arch/arm/configs/keystone_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> index ec9a41d50680..b3057730689f 100644
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -112,6 +112,7 @@ CONFIG_MTD_PLATRAM=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_DAVINCI=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_MTD_UBI=y
>  CONFIG_PROC_DEVICETREE=y
>  CONFIG_BLK_DEV_LOOP=y
> 
