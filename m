From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Sep 2016 12:24:40 +0100
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.9 -
 part1
In-Reply-To: <20160915101535.GC3380@arm.com>
References: <CADaLNDkZdAipxx6cfLJ6yrzTrcLPS_Ciw8+T5EUFVcRRw+fjPw@mail.gmail.com>
 <CADaLNDmMEWEd4o-tf4Kcqy7PP-abBg=Q1-Qdvv5CoDdoLEvi=Q@mail.gmail.com>
 <20160915072709.GA3380@arm.com> <5104796.MOduSCrlzf@wuerfel>
 <20160915101535.GC3380@arm.com>
Message-ID: <20160915112440.GD6718@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 11:15:35AM +0100, Will Deacon wrote:
> From 436d3a7ad25517433fc8f563f44fdab3c4801666 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Thu, 15 Sep 2016 10:14:41 +0100
> Subject: [PATCH] MAINTAINERS: Update ARM PMU PROFILING AND DEBUGGING entry
> 
> There are an increasing number of ARM SoC PMU drivers appearing for
> things like interconnects, memory controllers and cache controllers.
> Rather than have these handled on an ad-hoc basis, where SoC maintainers
> each send their PMU drivers directly to arm-soc, let's take these into
> drivers/perf/ and send a single pull request to arm-soc instead, much
> like other subsystems.
> 
> This patch amends the ARM PMU MAINTAINERS entry to include all of
> drivers/perf/ (currently just the ARM CPU PMU), changes Mark Rutland
> from Reviewer to Maintainer, so that he can help with the new tree and
> adds the device-tree binding to the list of maintained files.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6781a3febd59..090694e685ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -913,15 +913,16 @@ F:	arch/arm/include/asm/floppy.h
>  
>  ARM PMU PROFILING AND DEBUGGING
>  M:	Will Deacon <will.deacon@arm.com>
> -R:	Mark Rutland <mark.rutland@arm.com>
> +M:	Mark Rutland <mark.rutland@arm.com>
>  S:	Maintained
>  F:	arch/arm*/kernel/perf_*
>  F:	arch/arm/oprofile/common.c
>  F:	arch/arm*/kernel/hw_breakpoint.c
>  F:	arch/arm*/include/asm/hw_breakpoint.h
>  F:	arch/arm*/include/asm/perf_event.h
> -F:	drivers/perf/arm_pmu.c
> +F:	drivers/perf/*
>  F:	include/linux/perf/arm_pmu.h
> +F:	Documentation/devicetree/bindings/arm/pmu.txt
>  
>  ARM PORT
>  M:	Russell King <linux@armlinux.org.uk>
> -- 
> 2.5.0
> 
