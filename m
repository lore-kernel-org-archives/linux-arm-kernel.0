From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Mar 2012 12:50:21 -0700
Subject: [PATCH 08/11] ARM: tegra: Move tegra_pcie_xclk_clamp() to PMC
In-Reply-To: <1331218291-16119-9-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-9-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F590D7D.70308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2012 07:51 AM, Thierry Reding wrote:
> The PMC code already accesses the PMC registers so it makes sense to
> move this function there as well. While at it, rename the function to
> tegra_pmc_pcie_xclk_clamp() for consistency.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
