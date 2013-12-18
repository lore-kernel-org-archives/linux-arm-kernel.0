From: horms@verge.net.au (Simon Horman)
Date: Wed, 18 Dec 2013 10:08:15 +0900
Subject: [GIT PULL] Renesas ARM based SoC Clocksource updates for v3.14
In-Reply-To: <cover.1387000863.git.horms+renesas@verge.net.au>
References: <cover.1387000863.git.horms+renesas@verge.net.au>
Message-ID: <20131218010815.GA2430@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 14, 2013 at 03:07:31PM +0900, Simon Horman wrote:
> Hi Daniel,
> 
> please consider this Renesas ARM based SoC Clocksource update for v3.14.
> 
> I would also like to request that you make a branch available
> for me to use as a base for a branch containing SoC changes
> targeted at v3.14 that depend on this clocksource update.
> 
> Thanks

Hi Daniel,

sorry to bother you about this, but if you could take a moment
to look at this pull request I would be most grateful. Its
rather important for us.

> 
> 
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocksource-for-v3.14
> 
> for you to fetch changes up to d78e9474459768c9aaf8cfd8bc54957d44771f46:
> 
>   clocksource: sh_cmt: Add clk_prepare/unprepare support (2013-12-14 12:57:36 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC Clocksource updates for v3.14
> 
> * Add clk_prepare/unprepare support to sh_cmt
> 
> ----------------------------------------------------------------
> Laurent Pinchart (1):
>       clocksource: sh_cmt: Add clk_prepare/unprepare support
> 
>  drivers/clocksource/sh_cmt.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
