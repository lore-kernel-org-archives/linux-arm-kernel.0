From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Oct 2013 16:29:00 -0600
Subject: [PATCH 3/5] clk: tegra124: Add common clk IDs to clk-id.h
In-Reply-To: <1380878014-22088-4-git-send-email-pdeschrijver@nvidia.com>
References: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
 <1380878014-22088-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5254872C.9010307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2013 03:12 AM, Peter De Schrijver wrote:
> Tegra124 introduces a number of a new clocks. Introduce the corresponding
> the IDs for them.

> diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h

> +	tegra124_clk_isp,

Why does that one clock have a "tegra124_" name prefix, whereas all the
rest are just "tegra_"?
