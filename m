From: horms@verge.net.au (Simon Horman)
Date: Thu, 5 Jul 2018 17:55:15 +0200
Subject: [PATCH 5/5] ARM: shmobile: defconfig: Set CONFIG_LOCALVERSION
In-Reply-To: <20180704114333.27584-6-geert+renesas@glider.be>
References: <20180704114333.27584-1-geert+renesas@glider.be>
 <20180704114333.27584-6-geert+renesas@glider.be>
Message-ID: <20180705155513.ooppf45agiebi732@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 01:43:33PM +0200, Geert Uytterhoeven wrote:
> This allows to derive the kernel flavor from the kernel version at
> runtime.

For my edification could you expand on what this is used for?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - shmobile_defconfig is the only shmobile defconfig left.
> ---
>  arch/arm/configs/shmobile_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index ac3dad3c3b9dc9c6..b961c121515b7f06 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -1,3 +1,4 @@
> +CONFIG_LOCALVERSION="-shmobile"
>  CONFIG_SYSVIPC=y
>  CONFIG_NO_HZ=y
>  CONFIG_IKCONFIG=y
> -- 
> 2.17.1
> 
