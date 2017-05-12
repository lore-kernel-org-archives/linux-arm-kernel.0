From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 12 May 2017 08:39:50 +0200
Subject: [PATCH 1/2] ARM: at91/defconfig: make system tickless when idle
In-Reply-To: <20170505084343.10417-1-quentin.schulz@free-electrons.com>
References: <20170505084343.10417-1-quentin.schulz@free-electrons.com>
Message-ID: <00d91ef0-14f8-6065-2208-f4d7116adab7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 05/05/2017 10:43, Quentin Schulz wrote:
> This makes Atmel sama5 platforms' system tickless when idle.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

It's been a week since I posted this patch series. Any comment?

Thanks,
Quentin

> ---
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 777c9e986425..2e1f096c96cb 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -3,6 +3,7 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_FHANDLE=y
>  CONFIG_IRQ_DOMAIN_DEBUG=y
> +CONFIG_NO_HZ_IDLE=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
