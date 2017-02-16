From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Feb 2017 20:08:27 +0100
Subject: [PATCH 20/21] ARM: sunxi: Enable dwmac-sun8i driver on
 sunxi_defconfig
In-Reply-To: <20170216124859.14346-21-clabbe.montjoie@gmail.com>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
 <20170216124859.14346-21-clabbe.montjoie@gmail.com>
Message-ID: <20170216190827.jaky5xyzqtuzhy76@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 16, 2017 at 01:48:58PM +0100, Corentin Labbe wrote:
> From: LABBE Corentin <clabbe.montjoie@gmail.com>
> 
> Enable the dwmac-sun8i driver in the sunxi default configuration
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/configs/sunxi_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index da92c25..33bde86 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -40,6 +40,7 @@ CONFIG_ATA=y
>  CONFIG_AHCI_SUNXI=y
>  CONFIG_NETDEVICES=y
>  CONFIG_SUN4I_EMAC=y
> +CONFIG_DWMAC_SUN8I=m

I think I'd prefer to have it compiled statically, just like the other
net drivers, and drivers in general.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/8e530cfb/attachment.sig>
