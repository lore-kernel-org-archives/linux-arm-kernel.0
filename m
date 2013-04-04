From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Apr 2013 11:24:50 -0700
Subject: [GIT PULL] ARM: OMAP2+: GPMC updates
In-Reply-To: <515CE38B.3080400@ti.com>
References: <515B0D92.6070503@ti.com> <20130403214036.GD10155@atomide.com>
 <515CE38B.3080400@ti.com>
Message-ID: <20130404182447.GN10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130403 19:25]:
> 
> On 04/03/2013 04:40 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [130402 10:00]:
> >> The following changes since commit dca3a783400a18e2bf4503b1d4a85c4d0ca1a7e4:
> >>
> >>   Merge commit '31d9adca82ce65e5c99d045b5fd917c702b6fce3' into tmp (2013-04-01 14:33:50 -0500)
> >>
> >> are available in the git repository at:
> >>
> >>
> >>   git://github.com/jonhunter/linux.git omap-gpmc-for-v3.10
> >>
> >> for you to fetch changes up to c67bd6e7cad2160c3bbfa2ac2bd954f918301c23:
> >>
> >>   ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes (2013-04-01 14:53:50 -0500)
> >>
> >> ----------------------------------------------------------------
> >> Adds GPMC DT support for NOR flash and Ethernet and includes
> >> various GPMC cleans-up and fixes.
> >>
> >> This series is dependent on commit 7185684 (ARM: OMAP: use
> >> consistent error checking) from RMK's clean-up branch and commit
> >> 31d9adc (ARM: OMAP2+: Fix broken gpmc support).
> > 
> > Looks good except it adds a new warning:
> > 
> > arch/arm/mach-omap2/gpmc.c: In function ?gpmc_read_timings_dt?:
> > arch/arm/mach-omap2/gpmc.c:1324: warning: ?p? may be used uninitialized in this function
> > 
> > Can you please take a look?
> 
> No problem. I did not see get this warning, but I believe that 
> there is a bug that needed to be fixed. Can you try the below?

Thanks yes that works. Pulling into omap-for-v3.10/gpmc.

Regards,

Tony
