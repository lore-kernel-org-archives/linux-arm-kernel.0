From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 09 Feb 2014 23:49:34 +0100
Subject: [PATCH 28/28] Remove LOCAL_TIMERS
In-Reply-To: <1391971686-9517-29-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-29-git-send-email-richard@nod.at>
Message-ID: <1391986174.25855.95.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-02-09 at 19:48 +0100, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Merge with 26/28? Anyhow, my comments are basically identical to those
on that patch. So:
    Acked-by: Paul Bolle <pebolle@tiscali.nl>


Paul Bolle 

>  arch/arm/mach-omap2/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 653b489..2817f1f 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -54,7 +54,6 @@ config SOC_OMAP5
>  	select ARM_GIC
>  	select CPU_V7
>  	select HAVE_ARM_SCU if SMP
> -	select HAVE_ARM_TWD if LOCAL_TIMERS
>  	select HAVE_SMP
>  	select HAVE_ARM_ARCH_TIMER
>  	select ARM_ERRATA_798181 if SMP
