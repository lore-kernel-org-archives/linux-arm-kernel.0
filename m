From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 12 May 2014 11:35:14 +0300
Subject: pull request for Tegra PLLE fixes
In-Reply-To: <20140423145939.GA11307@tbergstrom-lnx.Nvidia.com>
References: <20140423145939.GA11307@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140512083514.GW30476@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 04:59:39PM +0200, Peter De Schrijver wrote:
> Hi Mike,
> 
> This fixes a number of stability problems with PCIe on Tegra30.
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
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

Mike,

Did you take this in?

Thanks,

Peter.
