From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Aug 2014 11:46:41 -0600
Subject: [PATCH v3 8/8] ARM: tegra: Add options for Tegra AHCI support
 to tegra_defconfig
In-Reply-To: <1405500863-19696-9-git-send-email-mperttunen@nvidia.com>
References: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com>
 <1405500863-19696-9-git-send-email-mperttunen@nvidia.com>
Message-ID: <53FCC801.5000703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2014 02:54 AM, Mikko Perttunen wrote:
> This adds ATA, SATA_AHCI and AHCI_TEGRA support to tegra_defconfig
> so that the SATA support will be automatically enabled.

I've applied this to Tegra's for-3.18/dt branch.
