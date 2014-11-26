From: joe@perches.com (Joe Perches)
Date: Tue, 25 Nov 2014 17:59:06 -0800
Subject: [PATCH 2/2] MAINTAINERS: ARM Versatile Express platform
In-Reply-To: <20141126015452.12298.30373@quantum>
References: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
 <1416939455-1814-2-git-send-email-pawel.moll@arm.com>
 <20141126015452.12298.30373@quantum>
Message-ID: <1416967146.8358.19.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-11-25 at 17:54 -0800, Mike Turquette wrote:
> Quoting Pawel Moll (2014-11-25 10:17:35)
> > This patch adds a separate section for the ARM
> > Versatile Express platform maintainers, listing
> > all different bits and bobs used by it.
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > +ARM/VERSATILE EXPRESS PLATFORM
[]
> > +F:     arch/arm/boot/dts/vexpress-*
> > +F:     arch/arm/mach-vexpress/*
> > +F:     drivers/bus/vexpress-config.c
> > +F:     drivers/clk/versatile/clk-vexpress-osc.c
> > +F:     drivers/clocksource/versatile.c
> > +F:     drivers/cpufreq/vexpress-spc-cpufreq.c
> > +F:     drivers/hwmon/vexpress.c
> > +F:     drivers/mfd/vexpress-sysreg.c
> > +F:     drivers/misc/vexpress-vexpress-syscfg.c
> > +F:     drivers/power/reset/vexpress-poweroff.c
> > +F:     drivers/regulator/vexpress.c
> > +F:     include/linux/vexpress.h
> >

maybe
F:	arch/arm/boot/dts/vexpress*
F:	arch/arm/mach-vexpress/
F:	*/*/vexpress*
F:	*/*/*/*vexpress*
F:	drivers/clocksource/versatile.c
