From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 11:54:22 +0200
Subject: [PATCH] ARM: configs: Switching to the new Marvell's
 cryptographic engine driver for mvebu_v5_defconfig
In-Reply-To: <1459238548-28029-1-git-send-email-romain.perier@free-electrons.com>
 (Romain Perier's message of "Tue, 29 Mar 2016 10:02:28 +0200")
References: <1459238548-28029-1-git-send-email-romain.perier@free-electrons.com>
Message-ID: <87egasuw8h.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,
 
 On mar., mars 29 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> This enables the new driver for Marvell CESA crypto engines on all mvebu v5.
> The old driver is no longer used, but it is still in the tree for fallback.
>
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>

As we already spoke about it with Andrew and Jason I applied it on
mvebu/defconfig.

Thanks,

Gregory

> ---
>  arch/arm/configs/mvebu_v5_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 4562006..6051c51 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -208,8 +208,8 @@ CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_PREEMPT is not set
>  # CONFIG_FTRACE is not set
>  CONFIG_DEBUG_USER=y
> +CONFIG_CRYPTO_DEV_MARVELL_CESA=y
>  CONFIG_CRYPTO_CBC=m
>  CONFIG_CRYPTO_PCBC=m
> -CONFIG_CRYPTO_DEV_MV_CESA=y
>  CONFIG_CRC_CCITT=y
>  CONFIG_LIBCRC32C=y
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
