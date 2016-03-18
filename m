From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 18 Mar 2016 14:14:32 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318081209.GA7394@archy.home>
References: <20160318081209.GA7394@archy.home>
Message-ID: <20160318131432.GB8005@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 09:12:09AM +0100, Romain Perier wrote:
> This enables the new driver for Marvell CESA crypto engines on all mvebu v7.

Hi Romain

Isn't this also applicable to mvebu v5?

And your change to multi_v7_defconfig could also be applied to
multi_v5_defconfig.

Thanks
	Andrew
 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index dc5797a..26a8919 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -155,3 +155,4 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TIMER_STATS=y
>  # CONFIG_DEBUG_BUGVERBOSE is not set
>  CONFIG_DEBUG_USER=y
> +CONFIG_CRYPTO_DEV_MARVELL_CESA=m
> -- 
> 2.7.3
> 
