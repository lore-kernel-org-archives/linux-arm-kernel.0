From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 14:56:47 -0700
Subject: [GIT PULL] berlin dt changes for v4.18
In-Reply-To: <20180524160619.45aaead2@xhacker.debian>
References: <20180524160619.45aaead2@xhacker.debian>
Message-ID: <20180525215647.xez6iukpgslbphru@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 04:06:19PM +0800, Jisheng Zhang wrote:
> Hi,
> 
> Here is the pull request for berlin dt changes for v4.18.
> 
> Thanks,
> Jisheng
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin-dt-for-v4.18
> 
> for you to fetch changes up to 15cf848d3c208159410eff2055494163c2542bbb:
> 
>   ARM: dts: berlin2q: move PMU node from soc to root (2018-05-24 15:25:44 +0800)
> 
> ----------------------------------------------------------------
> berlin DT changes for v4.18
> 
>  - add Valve Steam Link board support
>  - use PWM for chromecast's LED, override chromecast's bootloader
>    bad ATAG_MEM.
>  - fix twd timer irq type
>  - add interrupt-affinity to BG2Q's pmu
>  - add "cache-unified" to BG2Q's l2 node
>  - use SPDX-License-Identifier

Merged, thanks!


-Olof
