From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Sep 2010 08:21:39 -0700
Subject: [GIT PULL] omap2 sparse fixes
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F917C@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
	<20100923225851.GR4211@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
	<20100925001914.GO4211@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F917C@dbde02.ent.ti.com>
Message-ID: <20100928152139.GB3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* G, Manjunath Kondaiah <manjugk@ti.com> [100928 01:04]:
> 
> Three patches are fixed using above method which are:
> OMAP: mach-omap2: Fix static function warnings
> OMAP: plat-omap: Fix static function warnings
> TWL IRQ: Fix fucntion declaration warnings

OK thanks.
 
> are available in the git repository at:
> 
>   git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git sparse_fixes_v3
> 
> G, Manjunath Kondaiah (10):
>       OMAP: mach-omap2: Fix incorrect assignment warnings
>       OMAP: mach-omap2: Fix static declaration warnings
>       OMAP2plus: Fix static function warnings
>       OMAP: mach-omap2: Fix miscellaneous sparse warnings
>       OMAP: plat-omap: Fix static function warnings
>       OMAP: NAND: Fix static declaration warning
>       TWL CORE: Fix sparse warning
>       TWL IRQ: Fix fucntion declaration warnings

Didn't Samuel just reply that he has applied these two TWL fixes?

>       OMAP2/3: Convert write/read functions to raw read/write
>       OMAP3: Keypad: Fix incorrect type initializer

Regards,

Tony
