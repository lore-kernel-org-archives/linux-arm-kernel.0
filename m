From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Jun 2012 11:24:06 -0600
Subject: [PATCH 0/6] Port Tegra to generic clk framework
In-Reply-To: <1340879846-12900-1-git-send-email-pgaikwad@nvidia.com>
References: <1340879846-12900-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FEDE4B6.4010405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2012 04:37 AM, Prashant Gaikwad wrote:
> This patch set ports Tegra clock code to generic clock framework.
> 
> Depends on
> [PATCH v3 0/9] Add clk_prepare/clk_unprepare series
> [PATCH] ARM: tegra: Remove second instance of uart clk
> [PATCH] dma: tegra: add clk_prepare/clk_unprepare
> [PATCH] ARM: tegra: dma: rename driver name for clock to "tegra-apbdma"

Prashant, this doesn't apply either to my local development tree
(roughly what's in next-20120629), nor Tegra's for-3.6/common-clk
branch. Can you please regenerate the series on top of
for-3.6/common-clk. Thanks.
