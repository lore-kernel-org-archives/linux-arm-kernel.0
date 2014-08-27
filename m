From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Aug 2014 10:26:17 -0600
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Tegra AHCI driver
In-Reply-To: <1409122275-16464-1-git-send-email-mperttunen@nvidia.com>
References: <1409122275-16464-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <53FE06A9.4090509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 12:51 AM, Mikko Perttunen wrote:
> This enables AHCI_TEGRA by default. This driver is required
> for Serial ATA support on Tegra124-based boards.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
