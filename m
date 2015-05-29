From: balbi@ti.com (Felipe Balbi)
Date: Fri, 29 May 2015 12:20:04 -0500
Subject: [PATCH] ARM: omap2plus_defconfig: Add dm816x USB PHY as a
 loadable module
In-Reply-To: <1432919532-20445-1-git-send-email-tony@atomide.com>
References: <1432919532-20445-1-git-send-email-tony@atomide.com>
Message-ID: <20150529171927.GJ2026@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 10:12:12AM -0700, Tony Lindgren wrote:
> This is needed for USB on dm816x-evm.
> 
> Cc: Bin Liu <binmlist@gmail.com>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: George Cherian <george.cherian@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

it's a module, fine by me:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 4380291..92e4206 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -402,6 +402,7 @@ CONFIG_PWM_TIECAP=m
>  CONFIG_PWM_TIEHRPWM=m
>  CONFIG_PWM_TWL=m
>  CONFIG_PWM_TWL_LED=m
> +CONFIG_PHY_DM816X_USB=m
>  CONFIG_OMAP_USB2=m
>  CONFIG_TI_PIPE3=y
>  CONFIG_TWL4030_USB=m
> -- 
> 2.1.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/09b28e42/attachment.sig>
