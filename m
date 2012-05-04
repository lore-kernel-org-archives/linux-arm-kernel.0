From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 May 2012 10:53:58 -0600
Subject: [PATCH 1/1] ARM: tegra: Add Tegra Memory Controller(MC) driver
In-Reply-To: <20120504.160035.1828735037330038337.hdoyu@nvidia.com>
References: <1336063897-12083-1-git-send-email-hdoyu@nvidia.com><4FA2D0C4.4020608@wwwdotorg.org>
 <20120504.160035.1828735037330038337.hdoyu@nvidia.com>
Message-ID: <4FA409A6.3020700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 07:00 AM, Hiroshi Doyu wrote:
...
> What about the following AHB patches? AHB patches are independent of
> MC/GART/SMMU DT issue basically. If you think that they are ready to
> merge, I'll post the update version, I fixed some of your latest
> comments.
> 
>  [PATCH 1/3] ARM: tegra: Add Tegra AHB driver
>  [PATCH 2/3] ARM: tegra: Add SMMU enabler in AHB
>  [PATCH 3/3] ARM: dt: tegra: Add device tree support for AHB

Yes, I think they be reposted and go in now.

> I'll hold off on the following until we get some direction for
> MC/GART/SMMU. They are related to how dt info is passed via MC.
> 
>  [PATCH 1/3] ARM: tegra: Add Tegra Memory Controller(MC) driver
>  [PATCH 2/3] ARM: dt: tegra: Add device tree support for Memory Controller(MC)
>  [PATCH 3/3] iommu/tegra: smmu: Refrain from accessing to AHB
