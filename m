From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Nov 2014 15:19:08 +0100
Subject: [PATCH] ARM: at91: sama5: update defconfig
In-Reply-To: <1413982758-3579-1-git-send-email-ludovic.desroches@atmel.com>
References: <1413982758-3579-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <546CA6DC.50201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/10/2014 14:59, Ludovic Desroches :
> Add neon support for sama5d4 and large blocks/files support.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and stacked with Alexandre's Ack on top of at91-3.19-defconfig

Thanks, bye,

> ---
>  arch/arm/configs/sama5_defconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index c9089c9..69b6700 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -12,7 +12,7 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_FORCE_LOAD=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_MODULE_FORCE_UNLOAD=y
> -# CONFIG_LBDAF is not set
> +CONFIG_LBDAF=y
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
> @@ -30,6 +30,8 @@ CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 r
>  CONFIG_KEXEC=y
>  CONFIG_AUTO_ZRELADDR=y
>  CONFIG_VFP=y
> +CONFIG_NEON=y
> +CONFIG_KERNEL_MODE_NEON=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_PM_RUNTIME=y
>  CONFIG_PM_DEBUG=y
> 


-- 
Nicolas Ferre
