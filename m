From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 23 May 2014 20:34:13 +0200
Subject: [PATCH v3 4/4] ARM: multi_v5: Enable LaCie 2Big and 5Big Network
 v2
In-Reply-To: <1399839712-2416-5-git-send-email-andrew@lunn.ch>
References: <1399839712-2416-1-git-send-email-andrew@lunn.ch>
 <1399839712-2416-5-git-send-email-andrew@lunn.ch>
Message-ID: <20140523183413.GP6755@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 10:21:52PM +0200, Andrew Lunn wrote:
> Enable building LaCie 2Big and 5Big Network v2 in the multi v5 kernel.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/multi_v5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> index 5ebfa8bf8509..02d4e79826d3 100644
> --- a/arch/arm/configs/multi_v5_defconfig
> +++ b/arch/arm/configs/multi_v5_defconfig
> @@ -11,6 +11,7 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_KIRKWOOD=y
> +CONFIG_MACH_NETXBIG=y
>  CONFIG_ARCH_MXC=y
>  CONFIG_MACH_IMX25_DT=y
>  CONFIG_MACH_IMX27_DT=y

If you add the DT fan node, then you want CONFIG_SENSORS_G762=y here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/8b16546d/attachment-0001.sig>
