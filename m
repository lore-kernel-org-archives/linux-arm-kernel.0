From: horms@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:49:36 +0900
Subject: [PATCH] ARM: shmobile: Enable r8a7794 SoC in shmobile_defconfig
In-Reply-To: <1410309887-15492-1-git-send-email-horms+renesas@verge.net.au>
References: <1410309887-15492-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140911004936.GA23371@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 09:44:47AM +0900, Simon Horman wrote:
> Support for the r8a7794 was recently added.
> Enable it in the shmobile_defconfig to increase build coverage.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.

> ---
> 
> Based on renesas-devel-20140910v2-v3.17-rc4
>  arch/arm/configs/shmobile_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 522275a..d7346ad 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -16,6 +16,7 @@ CONFIG_ARCH_R8A7740=y
>  CONFIG_ARCH_R8A7779=y
>  CONFIG_ARCH_R8A7790=y
>  CONFIG_ARCH_R8A7791=y
> +CONFIG_ARCH_R8A7794=y
>  CONFIG_MACH_KOELSCH=y
>  CONFIG_MACH_LAGER=y
>  CONFIG_MACH_MARZEN=y
> -- 
> 2.0.1
> 
