From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Nov 2012 14:00:17 -0700
Subject: [PATCH 1/1] arm: tegra: select correct parent clk for pll_p
In-Reply-To: <1353396556-7738-1-git-send-email-sivaramn@nvidia.com>
References: <1353396556-7738-1-git-send-email-sivaramn@nvidia.com>
Message-ID: <50B3D861.7050700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 12:29 AM, Sivaram Nair wrote:
> For Tegra30, pll_p clk's parent is wrongly specified as clk_m instead of
> pll_ref in the tegra30_clk_init_table and this is resulting in a
> boot-time warning. This patch fixes this by correcting the clk init
> table.

Thanks, applied.
