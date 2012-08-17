From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 Aug 2012 13:26:41 -0600
Subject: [PATCH] ARM: tegra: clocks: separate tegra_clk_32k_ops from
 Tegra20 and Tegra30
In-Reply-To: <1345186281-3859-1-git-send-email-josephl@nvidia.com>
References: <1345186281-3859-1-git-send-email-josephl@nvidia.com>
Message-ID: <502E9AF1.2000701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2012 12:51 AM, Joseph Lo wrote:
> Currently the tegra20 and tegra30 share the same symbol for
> tegra_clk_32k_ops. This will cause a compile error when building
> a tegra20-only kernel image. Add tegra_clk_32k_ops for tegra20 and
> modify tegra30_clk_32k_ops for tegra30.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>

Thanks, applied to Tegra's for-3.7/common-clk branch.
