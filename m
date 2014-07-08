From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 08 Jul 2014 05:49:10 -0700
Subject: pull request for Tegra clock updates for 3.17 (update)
In-Reply-To: <20140708105811.GA23132@tbergstrom-lnx.Nvidia.com>
References: <20140708105811.GA23132@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140708124910.9850.46945@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2014-07-08 03:58:12)
> Hi Mike,
> 
> A few bug fixes for Tegra124 clocks and some updates for the SATA driver.
> This pull request includes 1 more patch PLLE clocking to make it work for
> both SATA and XUSB.

Pulled.

Thanks,
Mike

> 
> Thanks,
> 
> Peter.
> 
> The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:
> 
>   Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)
> 
> are available in the git repository at:
>   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-3.17-1
> 
> Mikko Perttunen (3):
>       clk: tegra: Enable hardware control of SATA PLL
>       clk: tegra: Add SATA clocks to Tegra124 initialization table
>       clk: tegra: Use XUSB-compatible SATA PLL sequence
> 
> Peter De Schrijver (3):
>       clk: tegra: fix vi_sensor clocks on Tegra124
>       clk: tegra124: init table updates
>       clk: tegra: export clock names for debugging
> 
>  drivers/clk/tegra/clk-pll.c          |   19 +++++++++++++++++++
>  drivers/clk/tegra/clk-tegra-periph.c |    4 ++--
>  drivers/clk/tegra/clk-tegra114.c     |   31 ++++++++++++++++++++++++++++++-
>  drivers/clk/tegra/clk-tegra124.c     |   10 +++++++++-
>  drivers/clk/tegra/clk.c              |    6 ++++++
>  5 files changed, 66 insertions(+), 4 deletions(-)
