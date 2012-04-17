From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Apr 2012 12:31:28 -0700
Subject: [GIT PULL] ARM: OMAP2+: hwmod: second set of fixes for 3.4-rc
In-Reply-To: <alpine.DEB.2.00.1204130624110.25832@utopia.booyaka.com>
References: <alpine.DEB.2.00.1204130624110.25832@utopia.booyaka.com>
Message-ID: <20120417193128.GG21106@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120413 05:29]:
> Hi Tony,
> 
> The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:
> 
>   Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-fixes-b-for-3.4rc
> 
> for you to fetch changes up to 1f5e6247ca99287bac87aff4971a7eee9c2b223a:
> 
>   ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC slave interface (2012-04-13 05:28:34 -0600)
> 
> ----------------------------------------------------------------
> A few OMAP hwmod fixes against v3.4-rc2.  One of them is a reversion
> of a previous v3.4-rc patch that caused some regressions, and upon
> further review, appears not to be necessary.  The other two are fairly
> minor.
> 

Thanks, this is now merged into fixes.

Tony
