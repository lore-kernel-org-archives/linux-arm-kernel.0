From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 28 Nov 2013 16:09:10 +0200
Subject: [PATCH] clk: tegra: add TEGRA_DIVIDER_ROUND_UP for periph clks
In-Reply-To: <5294FF83.7040905@wwwdotorg.org>
References: <1385484495-9835-1-git-send-email-pdeschrijver@nvidia.com>
 <5294FF83.7040905@wwwdotorg.org>
Message-ID: <20131128140910.GV26617@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 09:07:31PM +0100, Stephen Warren wrote:
> On 11/26/2013 09:48 AM, Peter De Schrijver wrote:
> > Perform upwards rounding when calculating dividers for periph clks on Tegra30
> > and Tegra114.
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> I tested audio and SPI on Dalmore and Beaver, using the following branch
> which has this commit integrated:
> git://nv-tegra.nvidia.com/user/pdeschrijver/linux tegra-clk-rework-1

Merged into clk-tegra-next
