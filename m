From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Jun 2016 21:43:49 -0700
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable AHCI_IMX
In-Reply-To: <1466427854-21265-1-git-send-email-tuomas@tuxera.com>
References: <1466427854-21265-1-git-send-email-tuomas@tuxera.com>
Message-ID: <20160621044349.GA24293@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Toumas,

We can apply this directly but I prefer to get an acked-by from the
platform maintainer that it affects. I didn't even see them cc:d here
so would you mind resubmit with them on the line? Alternatively send it
to them and they can apply and feed up to us with other defconfig changes.


-Olof

On Mon, Jun 20, 2016 at 04:04:13PM +0300, Tuomas Tynkkynen wrote:
> The Wandboard Quad comes with a SATA port. Enable the IMX SATA driver by
> default to make it easy to have the root filesystem on it.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index ee7c884..6efcbc7 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -214,6 +214,7 @@ CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_AHCI_PLATFORM=y
>  CONFIG_AHCI_ST=y
> +CONFIG_AHCI_IMX=y
>  CONFIG_AHCI_SUNXI=y
>  CONFIG_AHCI_TEGRA=y
>  CONFIG_SATA_HIGHBANK=y
> -- 
> 2.8.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
