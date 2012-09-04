From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 04 Sep 2012 16:05:39 -0600
Subject: [PATCH] ARM: tegra: remove tegra_timer from tegra_list_clks
In-Reply-To: <1346114317-28486-1-git-send-email-swarren@wwwdotorg.org>
References: <1346114317-28486-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50467B33.6010600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2012 06:38 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> tegra_time is a struct sys_timer, not a struct clk, so can't be included
> in an array of struct clk *.

Applied to Tegra's for-3.7/common-clk branch.
