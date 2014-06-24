From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Jun 2014 13:32:27 -0600
Subject: [PATCH v2 5/7] clk: tegra: Add SATA clocks to Tegra124
 initialization table
In-Reply-To: <1403101406-15439-6-git-send-email-mperttunen@nvidia.com>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
 <1403101406-15439-6-git-send-email-mperttunen@nvidia.com>
Message-ID: <53A9D24B.4040301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2014 08:23 AM, Mikko Perttunen wrote:
> This adds two clocks, SATA and SATA_OOB, to the Tegra124 clock initialization
> table. The clocks are needed for working SATA support.

Acked-by: Stephen Warren <swarren@nvidia.com>
(When I wrote that for v1, it applied to both patches 4 and 5, not just
patch 4)

Peter, can you please pick up patches 4 and 5, and get them into
linux-next. Thanks.
