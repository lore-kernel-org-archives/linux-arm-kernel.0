From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Dec 2013 13:23:30 -0800
Subject: [GIT PULL 0/3] Renesas SH SCI updates for v3.14
In-Reply-To: <cover.1387761495.git.horms+renesas@verge.net.au>
References: <cover.1387761495.git.horms+renesas@verge.net.au>
Message-ID: <20131229212330.GD20958@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 11:08:41AM +0900, Simon Horman wrote:
> Hi Kevin, Hi Olof, Hi Arnd,
> 
> please consider these Renesas SH SCI updates for v3.14.
> 
> They have been acked by Greg Kroah-Hartman to be taken
> through my tree. The reason for this is that they are dependencies
> for subsequent changes to use the common clock framework.
> 
> 
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-sci-for-v3.14
> 
> for you to fetch changes up to b016b646e8676858f39ea9be760494b04b9ee0af:
> 
>   serial: sh-sci: Convert to clk_prepare/unprepare (2013-12-14 09:59:31 +0900)

Merged into next/cleanup, since they're mostly bugfixes and they're a prereq
for other code so the dependency flow works better that way.


-Olof
