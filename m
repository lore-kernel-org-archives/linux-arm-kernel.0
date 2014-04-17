From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 17 Apr 2014 18:22:24 +0200
Subject: [PATCH 3/4] ARM: MVEBU: Add LaCie 2Big and 5Big Network v2
In-Reply-To: <1397750938-25381-4-git-send-email-andrew@lunn.ch>
References: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
 <1397750938-25381-4-git-send-email-andrew@lunn.ch>
Message-ID: <534FFFC0.6010908@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Why do you use capital for mvebu in the topic?
The arm-soc people asked us to use ARM in capital but for
mvebu I would prefer to keep it in small letter.

About the content of the patch itself I have no objection:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


On 17/04/2014 18:08, Andrew Lunn wrote:
> Enable building LaCie 2Big and 5Big Network v2 in the MVEBU v5 kernel.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/mvebu_v5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 36484a37a1ca..58acd057e236 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -12,6 +12,7 @@ CONFIG_MODULE_UNLOAD=y
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_KIRKWOOD=y
>  CONFIG_MACH_T5325=y
> +CONFIG_MACH_NETXBIG=y
>  # CONFIG_CPU_FEROCEON_OLD_ID is not set
>  CONFIG_PCI_MVEBU=y
>  CONFIG_PREEMPT=y
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
