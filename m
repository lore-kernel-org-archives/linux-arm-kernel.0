From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2012 11:55:53 -0700
Subject: [GIT PULL 2/10] omap soc clean-up for v3.5 merge window
In-Reply-To: <E1SSYHG-0005cy-Cu@merlin.infradead.org>
References: <pull-1336675159-747052> <E1SSYHG-0005cy-Cu@merlin.infradead.org>
Message-ID: <20120510185552.GL21851@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120510 11:47]:
> The following changes since commit 7a8bcf067d2b11964cb83ce3d753ac2d3ab9843c:
> 
>   Merge branch 'devel-hwmod' into cleanup (2012-05-08 10:17:32 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-for-v3.5
> 
> for you to fetch changes up to 2c65e7440d56b3b285d1c95563b4dcce8e40dea3:
> 
>   GPMC: add ECC control definitions (2012-05-10 09:39:47 -0700)
> 
> ----------------------------------------------------------------
> Clean up to make it easier to add support for new SoCs.
> 
> Note that these have a merge dependency to omap-devel-hwmod-for-v3.5
> branch for the Makefile changes.
> 
> ----------------------------------------------------------------

FYI, sets 2/10 and 3/10 have recent commit times as I had to fix a
mismerge in the cleanup branch and drop one patch that was causing build
errors for some cases.

Regards,

Tony
