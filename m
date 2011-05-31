From: tony@atomide.com (Tony Lindgren)
Date: Tue, 31 May 2011 05:39:35 -0700
Subject: [PATCH] ARM: omap4: Enable keypad controller hwmod
In-Reply-To: <1304546264-28922-1-git-send-email-ccross@android.com>
References: <1304546264-28922-1-git-send-email-ccross@android.com>
Message-ID: <20110531123935.GE11352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Colin Cross <ccross@android.com> [110504 14:54]:
> The keypad controller hwmod was left commented out, but the
> omap4-keypad driver requires it to function.

I'll queue an earlier patch doing the same thanks.

Regards,

Tony
 
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index abc548a..e1c69ff 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5109,7 +5109,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  	&omap44xx_iva_seq1_hwmod,
>  
>  	/* kbd class */
> -/*	&omap44xx_kbd_hwmod, */
> +	&omap44xx_kbd_hwmod,
>  
>  	/* mailbox class */
>  	&omap44xx_mailbox_hwmod,
> -- 
> 1.7.4.1
> 
