From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Jun 2011 06:35:38 -0700
Subject: [PATCH 3/3] Update Nook Color machine 3284 to common Encore name.
In-Reply-To: <1308066307-415-4-git-send-email-green@linuxhacker.ru>
References: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
	<1308066307-415-4-git-send-email-green@linuxhacker.ru>
Message-ID: <20110630133537.GP23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* green at linuxhacker.ru <green@linuxhacker.ru> [110614 08:42]:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> Machine database already updated:
> http://www.arm.linux.org.uk/developer/machines/list.php?id=3284
> 
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

Russell, do have some immutable branch containing the mach-types changes
that I could pull for my devel-board branch for this?

If you want me to apply this one along with the related board-*.c
changes please ack.

Regards,

Tony



> ---
>  arch/arm/tools/mach-types |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 3b3776d..fff68d0 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -910,7 +910,7 @@ omapl138_case_a3	MACH_OMAPL138_CASE_A3	OMAPL138_CASE_A3	3280
>  uemd			MACH_UEMD		UEMD			3281
>  ccwmx51mut		MACH_CCWMX51MUT		CCWMX51MUT		3282
>  rockhopper		MACH_ROCKHOPPER		ROCKHOPPER		3283
> -nookcolor		MACH_NOOKCOLOR		NOOKCOLOR		3284
> +encore			MACH_ENCORE		ENCORE			3284
>  hkdkc100		MACH_HKDKC100		HKDKC100		3285
>  ts42xx			MACH_TS42XX		TS42XX			3286
>  aebl			MACH_AEBL		AEBL			3287
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
