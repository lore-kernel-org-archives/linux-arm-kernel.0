From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Mar 2016 15:27:51 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for multi_v7_defconfig
In-Reply-To: <20160318084454.GA8836@archy.home> (Romain Perier's message of
 "Fri, 18 Mar 2016 09:44:54 +0100")
References: <20160318084454.GA8836@archy.home>
Message-ID: <87k2kz97yw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,
 
 On ven., mars 18 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> This enables the new driver for Marvell CESA crypto engines on all ARMv7.
>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2823490..392e970 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -829,6 +829,7 @@ CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_CRYPTO_DEV_TEGRA_AES=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_KEYSTONE_IRQ=y
> +CONFIG_CRYPTO_DEV_MARVELL_CESA=m
>  CONFIG_CRYPTO_DEV_SUN4I_SS=m
>  CONFIG_CRYPTO_DEV_ROCKCHIP=m
>  CONFIG_ARM_CRYPTO=y
> -- 
> 2.7.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
