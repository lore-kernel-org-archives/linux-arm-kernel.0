From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 18 Mar 2014 22:30:53 -0700
Subject: [GIT PULL] clk: mvebu: Armada 3xx changes for v3.15 (incr. #2)
In-Reply-To: <20140314142717.GC15608@titan.lakedaemon.net>
References: <20140314142717.GC15608@titan.lakedaemon.net>
Message-ID: <20140319053053.30995.60933@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jason Cooper (2014-03-14 07:27:17)
> Mike,
> 
> This is a small pull request, and should be the last one for v3.15.  We
> have a small fix for the new driver we introduced in v3.15, and we're
> expanding the core divider to support another SoC.
> 
> Due to some great work by Ezequiel and others, this is a small and simple
> change to make.
> 
> This pull request is an incremental pull from tags/clk-mvebu-3xx-3.15 up
> to tags/clk-mvebu-3xx-3.15-2 in the mvebu/clk-3xx branch.
> 
> Please pull.

Pull into clk-next.

Regards,
Mike

> 
> thx,
> 
> Jason.
> 
> 
> The following changes since commit e9646fe1169de0162d461472df7ed19e0c729b61:
> 
>   dt: Update binding information for mvebu gating clocks with Armada 380/385 (2014-02-17 02:34:08 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/clk-mvebu-3xx-3.15-2
> 
> for you to fetch changes up to e69a8543ec7730c46225c886f74f0ea57e4656c5:
> 
>   clk: mvebu: Update binding documentation for the core divider clock (2014-03-13 23:24:23 +0000)
> 
> ----------------------------------------------------------------
> clock: mvebu new SoC changes for v3.15 (incremental pull #2)
> 
>  - mvebu (Armada 375)
>     - fix ratio register offest
> 
>  - mvebu (Armada 380)
>     - expand core divider clock driver to support 380 SoC (enables nand support)
> 
> ----------------------------------------------------------------
> Ezequiel Garcia (3):
>       clk: mvebu: Fix ratio register offset on A375 SoC
>       clk: mvebu: Support Armada 380 SoC on the core divider clock
>       clk: mvebu: Update binding documentation for the core divider clock
> 
>  .../bindings/clock/mvebu-corediv-clock.txt         |  5 ++++-
>  drivers/clk/mvebu/clk-corediv.c                    | 25 +++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 2 deletions(-)
