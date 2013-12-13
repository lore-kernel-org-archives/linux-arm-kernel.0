From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 13 Dec 2013 04:15:29 +0100
Subject: [GIT PULL FOR v3.14] Renesas R-Car Gen 2 Common Clock Framework
In-Reply-To: <20131213031046.11981.97127@quantum>
References: <3302362.MUz5Y8N3ER@avalon> <20131213031046.11981.97127@quantum>
Message-ID: <2317239.Qa6C04GgRQ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thursday 12 December 2013 19:10:46 Mike Turquette wrote:
> Quoting Laurent Pinchart (2013-12-04 13:29:07)
> 
> > Hi Mike,
> > 
> > As nobody replied to the last version of the patches I will assume that
> > either they're perfect, or I've managed to make all reviewers hibernate
> > from boredom. Both cases call for a pull request.
> > 
> > Could you please pull the following three patches for v3.14 ? They have no
> > extra compile-time or runtime dependency, but subsequent platform patches
> > will depend on them. Could you thus please provide a stable branch that
> > Simon can merge in his tree ?
> > 
> > Changes compared to v4:
> > 
> > - Rebased on top of the latest clk-next branch
> > - Revert to ARCH_SHMOBILE_MULTI (as in v3) for drivers/clk/Makefile
> > 
> > The following changes since commit 
cdf64eeeb0d762585e2126f3024458d199c2635d:
> >   clk: exynos5420: fix cpll clock register offsets (2013-12-04 10:46:45
> >   -0800)> 
> > are available in the git repository at:
> >   git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/rcar-gen2-mainline
> > 
> > for you to fetch changes up to 7135ea019305179dd6f6a99ea7c1e78773eca166:
> >   clk: shmobile: Add MSTP clock support (2013-12-04 22:18:36 +0100)
> 
> Thanks for the pull request. This is a nicely formatted series.  Very
> easy to review.
> 
> Taken into clk-next.

Thank you.

Simon will need a stable branch with these three patches that he can merge in 
his tree. If you could apply the patches to a branch directly on top of a 
mainline tag (I think you're currently based on v3.13-rc1) and merge that to 
clk-next that would be perfect as it would minimize the amount of changes 
merged by Simon.

-- 
Regards,

Laurent Pinchart
