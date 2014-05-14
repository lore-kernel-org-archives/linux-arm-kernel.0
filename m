From: horms@verge.net.au (Simon Horman)
Date: Wed, 14 May 2014 14:08:02 +0900
Subject: [PATCH v6 00/12] CCF support for Renesas r7s72100
In-Reply-To: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20140514050801.GE3502@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 03:10:04AM +0200, Wolfram Sang wrote:
> This series moves the r7s72100 platfrom from the legacy clock implementation to
> the common clock framework.
> 
> This series has been tested with the renesas-devel-v3.15-rc2-20140428 tag. If
> you want to boot into a console, you have a runtime dependency [1] which is
> expected to go away in 3.15-rc6.
> 
> Changes since V5:
> 
> * rebased and tested against latest renesas/devel-tag
>   (with and without CCF)
> * added acks
> * added the patch from Geert, and folded another into the series
> 
> PS: A tree can be found here with this series and the dependency patch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r7s-ccf
> 
> [1] http://www.spinics.net/lists/linux-sh/msg30918.html (clk: shmobile: clk-mstp: change to using clock-indices)
> 
> Geert Uytterhoeven (1):
>   ARM: shmobile: Add forward declaration of struct clk to silence
>     warning

Thanks, I have queued up this series.
