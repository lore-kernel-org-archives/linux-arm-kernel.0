From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 19 May 2014 11:05:03 +0200
Subject: [PATCH v3 4/4] ARM: multi_v5: Enable LaCie 2Big and 5Big Network
 v2
In-Reply-To: <1400163836-9831-8-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-8-git-send-email-andrew@lunn.ch>
Message-ID: <5379C93F.8050302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added arm at kernel.org so they can spot the patch more easily]

On 05/15/2014 04:23 PM, Andrew Lunn wrote:
> Enable building LaCie 2Big and 5Big Network v2 in the multi v5 kernel.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   arch/arm/configs/multi_v5_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> index 5ebfa8bf8509..02d4e79826d3 100644
> --- a/arch/arm/configs/multi_v5_defconfig
> +++ b/arch/arm/configs/multi_v5_defconfig
> @@ -11,6 +11,7 @@ CONFIG_MODULE_UNLOAD=y
>   # CONFIG_ARCH_MULTI_V7 is not set
>   CONFIG_ARCH_MVEBU=y
>   CONFIG_MACH_KIRKWOOD=y
> +CONFIG_MACH_NETXBIG=y
>   CONFIG_ARCH_MXC=y
>   CONFIG_MACH_IMX25_DT=y
>   CONFIG_MACH_IMX27_DT=y
>
