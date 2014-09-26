From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 26 Sep 2014 16:09:59 -0700
Subject: pull request for Tegra clock updates for 3.18
In-Reply-To: <20140919123020.GA12341@tbergstrom-lnx.Nvidia.com>
References: <20140919123020.GA12341@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140926230959.19023.44549@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2014-09-19 05:30:20)
> Hi Mike,
> 
> A few fixes to enable PLL_M scaling for Tegra124 and improved error handling
> for clock initialization.

Pulled!

Thanks,
Mike

> 
> Thanks,
> 
> Peter.
> 
> The following changes since commit 9e82bf014195d6f0054982c463575cdce24292be:
> 
>   Linux 3.17-rc5 (2014-09-14 17:50:12 -0700)
> 
> are available in the git repository at:
>   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-3.18
> 
> Mikko Perttunen (2):
>       ARM: tegra: Add PLL_M_UD and PLL_C_UD to tegra124-car binding header
>       clk: tegra124: Add PLL_M_UD and PLL_C_UD clocks
> 
> Tomeu Vizoso (1):
>       clk: tegra: Make clock initialization more robust
> 
>  drivers/clk/tegra/clk-tegra124.c         |    8 ++++++++
>  drivers/clk/tegra/clk.c                  |    9 +++++++--
>  include/dt-bindings/clock/tegra124-car.h |    6 +++++-
>  3 files changed, 20 insertions(+), 3 deletions(-)
