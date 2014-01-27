From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 Jan 2014 10:00:40 -0500
Subject: [RFC/PATCH] ARM: dove: Remove UBI support from defconfig
In-Reply-To: <1390829189-25073-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390829189-25073-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140127150040.GH29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 10:26:29AM -0300, Ezequiel Garcia wrote:
> As NAND support is not enabled by default, it's hard to see
> why we'd want to have UBI support. Let's remove it.

I'd rather add support for the nand.

thx,

Jason.

> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/dove_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
> index 1101054..7242b11 100644
> --- a/arch/arm/configs/dove_defconfig
> +++ b/arch/arm/configs/dove_defconfig
> @@ -48,7 +48,6 @@ CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_STAA=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_M25P80=y
> -CONFIG_MTD_UBI=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_COUNT=1
> -- 
> 1.8.1.5
> 
