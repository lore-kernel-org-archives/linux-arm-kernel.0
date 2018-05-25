From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 15:25:53 -0700
Subject: [GIT PULL] late omap soc changes for v4.18 merge window
In-Reply-To: <pull-1527259829-686604@atomide.com>
References: <pull-1527259829-686604@atomide.com>
Message-ID: <20180525222553.tjewwse3mipiroic@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 07:51:20AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 3bb3799cd4233b7c24622ae8c41455fb27a55c0f:
> 
>   Merge branch 'omap-for-v4.18/soc-fixes' into omap-for-v4.18/soc (2018-05-21 10:34:17 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/soc-late-signed
> 
> for you to fetch changes up to 759c27bdc77577aaecb6f31768e5951a858f97a9:
> 
>   OMAP: CLK: CLKSRC: Add suspend resume hooks (2018-05-23 14:16:26 -0700)
> 
> ----------------------------------------------------------------
> Late omap soc changes for v4.18 merge window
> 
> This series contains two omap1 ams-delta GPIO clean-up patches to get
> started with removal of hard-coded GPIO numbers from drivers. And then
> the removal of board mach includes from drivers. The second patch mostly
> touches the ams-delta audio driver but is included here because of the
> removal of the latch gpios and is acked by Mark Brown.
> 
> And there are two more am437x related PM patches to save and restore
> control module and timer registers for RTC only suspend mode. Looks like
> the patch title for the timer changes is a bit misleading, not all the
> timer code is yet living under drivers/clocksource. But I had already
> pushed out the branch before I noticed this.

Merged, thanks!


-Olof
