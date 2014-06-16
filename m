From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 15:49:18 -0600
Subject: [PATCH 4/9] clk: tegra: Enable hardware control of SATA PLL
In-Reply-To: <1401881559-18469-5-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-5-git-send-email-mperttunen@nvidia.com>
Message-ID: <539F665E.3060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> This makes the SATA PLL be controlled by hardware instead of software.
> This is required for working SATA support.

Peter, could you please take patches 4 and 5 through the clock tree. As
far as I can tell, there's no compile-time dependency in the clock
patches, so they can go through a different tree to the rest of the
series without issue. These 2 patches look fine to me, so consider them:

Acked-by: Stephen Warren <swarren@nvidia.com>
