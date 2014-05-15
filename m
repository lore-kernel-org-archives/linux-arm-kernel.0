From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 14 May 2014 22:31:05 -0700
Subject: pull request for Tegra PLLE fixes
In-Reply-To: <20140423145939.GA11307@tbergstrom-lnx.Nvidia.com>
References: <20140423145939.GA11307@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140515053105.3084.44161@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2014-04-23 07:59:39)
> Hi Mike,
> 
> This fixes a number of stability problems with PCIe on Tegra30.
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

Pulled for -rc6.

Thanks,
Mike

> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
>   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git  clk-tegra-fixes-3.15
> 
> Thierry Reding (3):
>       clk: tegra: Fix PLLE programming
>       clk: tegra: Introduce divider mask and shift helpers
>       clk: tegra: Fix enabling of PLLE
> 
>  drivers/clk/tegra/clk-pll.c |   64 +++++++++++++++++++++++++++++--------------
>  1 files changed, 43 insertions(+), 21 deletions(-)
