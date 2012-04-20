From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Apr 2012 17:56:35 -0700
Subject: [GIT PULL] ARM: OMAP2+: hwmod data: add most of the remaining
 OMAP4 hwmods
In-Reply-To: <alpine.DEB.2.00.1204191428550.29048@utopia.booyaka.com>
References: <alpine.DEB.2.00.1204191428550.29048@utopia.booyaka.com>
Message-ID: <20120420005633.GZ21106@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120419 13:33]:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Tony,
> 
> The following changes since commit 3af35fbcd088e0b675fa423a879c596384894180:
> 
>   ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP (2012-04-19 04:25:08 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-devel-a-for-3.5
> 
> for you to fetch changes up to 96566043b19ae76d3828ce75cbf28dc6d0bcaaf1:
> 
>   ARM: OMAP4: hwmod data: add DEBUGSS skeleton (2012-04-19 13:33:59 -0600)
> 
> - ----------------------------------------------------------------
> Add in most of the remaining hwmods (IP block descriptions) for the
> OMAP44xx family of SoCs.  There still seem to be a few missing, such
> as those for the MMU IP blocks, but this seems to cover the bulk of
> the remainder.

Thanks merging this into devel-hwmod and merging into linux-omap master.

Just for reference, I now have omap-cleanup-a2-for-3.5, omap-cleanup-b-for-3.5
and omap-devel-a-for-3.5 merged, and I've dropped all the earlier branches
you posted.

So I'm assuming you'll be resending what was in hwmod_misc_devel_3.4,
clock_devel_3.4 and io_chain_devel_3.4 once you're done with your fixes/updates
for those.

Cheers,

Tony
