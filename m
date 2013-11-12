From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 15:40:21 -0700
Subject: [PATCHv4 0/7] Unifying SMMU driver among Tegra SoCs
In-Reply-To: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <5282AE55.1040701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> Hi,
> 
> This series provides:
> 
> (1) Unified SMMU driver among Tegra SoCs
> (2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
> (3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.
> 
> There's been some discussion[1] about device population order, and I
> added a IOMMU hook in driver core:
> 
>   [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
> 
> which is based on the following RFC patch:
> 
>   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
>   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html

I assume that "based on" means "is a new version of", so I don't need to
look at the "PATCHv3+" patch, since this series replaces it?
