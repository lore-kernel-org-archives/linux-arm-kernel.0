From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 11:23:29 -0600
Subject: [PATCH v3 2/8] ARM: tegra: Add SATA controller to Tegra124 device
 tree
In-Reply-To: <1405500863-19696-3-git-send-email-mperttunen@nvidia.com>
References: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com>
 <1405500863-19696-3-git-send-email-mperttunen@nvidia.com>
Message-ID: <53FB7111.2000602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2014 02:54 AM, Mikko Perttunen wrote:
> This adds the integrated AHCI-compliant Serial ATA controller present
> in Tegra124 systems-on-chip to the Tegra124 device tree.

I have applied patches 2 and 3 to Tegra's for-3.18/dt branch. I fixed 
the DT node sort order when doing so.

I can't apply patch 8 (the defconfig change) until 3.17-rc2 is out, or 
there will be a build failure, but I will do so ASAP.

BTW, once 3.17-rc2 is out, can you please sent a patch to 
multi_v7_defconfig enabling Tegra SATA support there too. Thanks.
