From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 Jan 2013 16:21:05 -0700
Subject: [PATCH V5 2/9] clk: tegra: Add tegra specific clocks
In-Reply-To: <1357942065-22508-1-git-send-email-swarren@wwwdotorg.org>
References: <1357942065-22508-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50F09E61.1080406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2013 03:07 PM, Stephen Warren wrote:
> From: Prashant Gaikwad <pgaikwad@nvidia.com>
> 
> Add tegra specific clocks, pll, pll_out, peripheral,
> frac_divider, super.

> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c

> +static int clk_plle_training(struct tegra_clk_pll *pll)
> +{
> +	u32 val;
> +	int timeout;

Oops, I need to fix that up to be an unsigned long. I won't bother
reposting for that unless there's some other reason to repost.
