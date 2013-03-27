From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Mar 2013 12:58:40 -0700
Subject: [GIT PULL] ARM: OMAP2+: Generic cleanups for 3.10
In-Reply-To: <5153431E.60007@ti.com>
References: <1363768789-17929-1-git-send-email-santosh.shilimkar@ti.com>
 <20130327180321.GB10155@atomide.com> <5153431E.60007@ti.com>
Message-ID: <20130327195839.GF10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130327 12:08]:
> On Wednesday 27 March 2013 11:33 PM, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [130320 01:42]:
> >> Tony,
> >>
> >> Here is the pull request for various OMAP cleanups and fixes which are posted
> >> earlier on the list. It contains OMAP4 smp cleanup, removal of unwanted static
> >> deps from OMAP4, RAM offset consolidation and fiq tuple cleanup. 
> >>
> >>
> >> The following changes since commit a937536b868b8369b98967929045f1df54234323:
> >>
> >>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap_generic_cleanup
> >>
> >> for you to fetch changes up to 37e1f64c3bc2b3455a9688de8527a341847b3ad9:
> >>
> >>   ARM: OMAP4: Fix the init code to have OMAP4460 errata available in DT build (2013-03-19 12:57:30 +0530)
> > 
> > Thanks pulled this into omap-for-v3.10/cleanup.
> > 
> Thanks Tony !!

Hmm looks like Kevin had some good comments and acks, can you
please update and send a new pull req? I'll set up cleanup-v2 branch
when those are available.

Regards,

Tony
