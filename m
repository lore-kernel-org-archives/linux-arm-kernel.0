From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2012 10:51:33 -0800
Subject: [GIT PULL 3/3] omap prcm cleanup for v3.8 merge window, part1
In-Reply-To: <E1TRrO0-00087R-UM@merlin.infradead.org>
References: <pull-1351286620-406688> <E1TRrO0-00087R-UM@merlin.infradead.org>
Message-ID: <20121105185133.GC22301@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 02:23:40PM -0700, Tony Lindgren wrote:
> The following changes since commit a0212796b58061a9716178d261f318925c246643:
> 
>   Merge tag 'omap-cleanup-fixes-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/cleanup-headers (2012-10-26 13:18:19 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-prcm-part1-take2-signed
> 
> for you to fetch changes up to 7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33:
> 
>   Merge branch 'omap-for-v3.8/cleanup-headers' into omap-for-v3.8/cleanup-prcm (2012-10-26 13:32:22 -0700)
> 
> ----------------------------------------------------------------
> 
> From Paul Walmsley <paul@pwsan.com>:
> 
> The first set of OMAP PRM/CM-related cleanup patches for 3.8.
> Prepares for the future move of the PRM/CM code to drivers/.  Also
> includes some prcm.[ch] cleanup patches from the WDTIMER cleanup
> series that don't need external acks.
> 
> ----------------------------------------------------------------
> Paul Walmsley (9):
>       ARM: OMAP2+: PRM: remove PRM weak functions
>       ARM: OMAP2+: PRM: split PRM functions into OMAP2, OMAP3-specific files
>       ARM: OMAP2+: powerdomain/PRM: move the low-level powerdomain functions into PRM
>       ARM: OMAP2+: CM/hwmod: split CM functions into OMAP2, OMAP3-specific files
>       ARM: OMAP2/3: clockdomain/PRM/CM: move the low-level clockdomain functions into PRM/CM
>       ARM: OMAP2+: PRM: prepare for use of prm_ll_data function pointers
>       ARM: OMAP2+: CM: prepare for use of cm_ll_data function pointers
>       ARM: OMAP1: create read_reset_sources() function (for initial use by watchdog)
>       ARM: OMAP2+: PRM: create PRM reset source API for the watchdog timer driver
> 
> Tony Lindgren (2):
>       Merge tag 'omap-cleanup-a-for-3.8' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.8/cleanup-prcm
>       Merge branch 'omap-for-v3.8/cleanup-headers' into omap-for-v3.8/cleanup-prcm

Hi,

The history of this branch looks a little odd. Did you mean to merge in
cleanup-headers on top of Paul's branch in it? It seems to add no value -- all
that code is already in our branch and it resolves no conflicts, etc.

That being said, it causes no harm, and I've pulled it in as is.


-Olof
