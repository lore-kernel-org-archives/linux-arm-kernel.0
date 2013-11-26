From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Nov 2013 13:07:31 -0700
Subject: [PATCH] clk: tegra: add TEGRA_DIVIDER_ROUND_UP for periph clks
In-Reply-To: <1385484495-9835-1-git-send-email-pdeschrijver@nvidia.com>
References: <1385484495-9835-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5294FF83.7040905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 09:48 AM, Peter De Schrijver wrote:
> Perform upwards rounding when calculating dividers for periph clks on Tegra30
> and Tegra114.

Tested-by: Stephen Warren <swarren@nvidia.com>

I tested audio and SPI on Dalmore and Beaver, using the following branch
which has this commit integrated:
git://nv-tegra.nvidia.com/user/pdeschrijver/linux tegra-clk-rework-1
