From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 12 Dec 2012 10:28:34 +0100
Subject: [PATCH 01/10] ARM: OMAP3/4: cpuidle: fix sparse and checkpatch
 warnings
In-Reply-To: <20121209012334.19716.44831.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012334.19716.44831.stgit@dusk.lan>
Message-ID: <50C84E42.2040402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 December 2012 02:23 AM, Paul Walmsley wrote:
> Fix the following sparse warnings in the OMAP3/4 CPUIdle code:
>
> arch/arm/mach-omap2/cpuidle34xx.c:272:1: warning: symbol 'omap3_idle_dev' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle34xx.c:274:23: warning: symbol 'omap3_idle_driver' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle44xx.c:164:1: warning: symbol 'omap4_idle_dev' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle44xx.c:166:23: warning: symbol 'omap4_idle_driver' was not declared. Should it be static?
>
> Also fix the following checkpatch warnings:
>
> WARNING: please, no space before tabs
> #44: FILE: arch/arm/mach-omap2/cpuidle34xx.c:105:
> +^I.name = ^I"omap3_idle",$
>
> WARNING: please, no space before tabs
> #45: FILE: arch/arm/mach-omap2/cpuidle34xx.c:106:
> +^I.owner = ^ITHIS_MODULE,$
>
> ERROR: code indent should use tabs where possible
> #211: FILE: arch/arm/mach-omap2/cpuidle44xx.c:74:
> +                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */$
>
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---

Acked-by: Santosh Shilimkar at ti.com
