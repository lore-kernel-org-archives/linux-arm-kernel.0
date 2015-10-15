From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 22:43:37 +0200
Subject: [GIT PULL] ARM: berlin: CPU clock driver for v4.4 (round 1)
In-Reply-To: <1444935864-8606-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1444934667-5451-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1444935864-8606-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <6081171.fTttdr29KV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 21:04:24 Sebastian Hesselbarth wrote:
> this is the remaining driver changes of the broken PRs sent earlier.
> Again, as Arnd requested this branch is based on the PR adding the
> CPUID to the dt-binding include and drops moving the MAX_CLKS
> define from the driver to the dt-binding include.

+clk maintainers

I've pulled it into next/drivers now to speed things up and given
that it has Stephen's Ack, but I'd note that now that the dependency
is handled correctly, this could have gone the normal path through the
clk maintainers.

Thanks,

	Arnd

> The following changes since commit 28c039eebaaa28def9364b9a12a30192be8b4730:
>   ARM: berlin: dts: add CLKID_CPU for BG2Q (2015-10-15 20:31:41 +0200)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/hesselba/linux-berlin.git
>   tags/berlin-new-cpuclk-for-4.4-1> 
> for you to fetch changes up to 515f1a2027006839c08c842da919abfcc3c7ae2a:
>   clk: berlin: add cpuclk (2015-10-15 20:55:55 +0200)
> 
> ----------------------------------------------------------------
> Marvell Berlin BG2Q CPU clock driver:
> - add BG2Q CPU clock to clk driver
> 
> ----------------------------------------------------------------
> 
> Antoine Tenart (1):
>       clk: berlin: add cpuclk
> 
> Sebastian Hesselbarth (1):
>       Merge tag 'berlin-dt-cpuclk-for-4.4-1' into berlin/cpuclk
>  
>  drivers/clk/berlin/bg2q.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
