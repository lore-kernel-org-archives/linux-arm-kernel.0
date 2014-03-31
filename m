From: balbi@ti.com (Felipe Balbi)
Date: Mon, 31 Mar 2014 10:21:48 -0500
Subject: [PATCH 07/55] ARM: OMAP3+: PRM: add cpu-type as parameter to
 prm_init calls
In-Reply-To: <1396278994-12624-8-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
 <1396278994-12624-8-git-send-email-t-kristo@ti.com>
Message-ID: <20140331152148.GE7760@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 31, 2014 at 06:15:46PM +0300, Tero Kristo wrote:
> diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
> index 8d95aa5..73734b2 100644
> --- a/arch/arm/mach-omap2/prm44xx_54xx.h
> +++ b/arch/arm/mach-omap2/prm44xx_54xx.h
> @@ -57,7 +57,7 @@ extern void omap44xx_prm_ocp_barrier(void);
>  extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
>  extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
>  
> -extern int __init omap44xx_prm_init(void);
> +int __init omap44xx_prm_init(u16 cpu_type);

trailing change ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140331/8630211b/attachment-0001.sig>
