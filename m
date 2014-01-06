From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 05 Jan 2014 21:43:22 -0800
Subject: pull request for some small fixes
In-Reply-To: <20131223162705.GE3378@tbergstrom-lnx.Nvidia.com>
References: <20131223162705.GE3378@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140106054322.26907.37296@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2013-12-23 08:27:05)
> The following changes since commit 62ce7cd62f534023224912dc9b909963f26a38da:
> 
>   clk: tegra: fix __clk_lookup() return value checks (2013-11-28 15:09:22 +0200)
> 
> are available in the git repository at:
>   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git clk-tegra-next-1

Hi Peter,

Do you intend for this to go as fixes for 3.13-rc8? The fixes are based
off of a commit from my clk-next branch.

Regards,
Mike

> 
> Peter De Schrijver (1):
>       clk: tegra: Add missing Tegra20 fuse clks
> 
> Thierry Reding (1):
>       clk: tegra: Correct clock number for UARTE
> 
>  drivers/clk/tegra/clk-tegra-periph.c |    2 +-
>  drivers/clk/tegra/clk-tegra20.c      |    2 ++
>  2 files changed, 3 insertions(+), 1 deletions(-)
