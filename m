From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 18:03:22 +0100
Subject: [PATCH 5/5] ARM: mvebu: update v5 defconfig for Orion5x machines
In-Reply-To: <1449012812-9779-6-git-send-email-andrew@lunn.ch> (Andrew Lunn's
 message of "Wed, 2 Dec 2015 00:33:32 +0100")
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
 <1449012812-9779-6-git-send-email-andrew@lunn.ch>
Message-ID: <87a8pmcht1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On mer., d?c. 02 2015, Andrew Lunn <andrew@lunn.ch> wrote:

> Now that Orion5x is part of the multiarch kernel, add it to
> mvebu_v5_defconfig.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/defconfig

Thanks,

Gregory
> ---
>  arch/arm/configs/mvebu_v5_defconfig | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index d7c17864a1eb..af29780accdc 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -12,7 +12,29 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_KIRKWOOD=y
> -# CONFIG_CPU_FEROCEON_OLD_ID is not set
> +CONFIG_ARCH_ORION5X=y
> +CONFIG_MACH_DB88F5281=y
> +CONFIG_MACH_RD88F5182=y
> +CONFIG_MACH_RD88F5182_DT=y
> +CONFIG_MACH_KUROBOX_PRO=y
> +CONFIG_MACH_DNS323=y
> +CONFIG_MACH_TS209=y
> +CONFIG_MACH_TERASTATION_PRO2=y
> +CONFIG_MACH_LINKSTATION_PRO=y
> +CONFIG_MACH_LINKSTATION_LSCHL=y
> +CONFIG_MACH_LINKSTATION_MINI=y
> +CONFIG_MACH_LINKSTATION_LS_HGL=y
> +CONFIG_MACH_TS409=y
> +CONFIG_MACH_WRT350N_V2=y
> +CONFIG_MACH_TS78XX=y
> +CONFIG_MACH_MV2120=y
> +CONFIG_MACH_D2NET_DT=y
> +CONFIG_MACH_NET2BIG=y
> +CONFIG_MACH_MSS2_DT=y
> +CONFIG_MACH_WNR854T=y
> +CONFIG_MACH_RD88F5181L_GE=y
> +CONFIG_MACH_RD88F5181L_FXO=y
> +CONFIG_MACH_RD88F6183AP_GE=y
>  CONFIG_PCI_MVEBU=y
>  CONFIG_PREEMPT=y
>  CONFIG_AEABI=y
> -- 
> 2.6.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
