From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 11 Aug 2017 17:21:25 +0200
Subject: [PATCH 0/4] IOMMU group cleanup
In-Reply-To: <cover.1500637633.git.robin.murphy@arm.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
Message-ID: <20170811152124.GH30515@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 01:12:34PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Prompted by some discussion around the questionable usefulness of
> iommu_present() for SoC topologies, I took a look at what was left to
> finish off the intention of making groups mandatory. Turns out it
> wasn't much, so here it is. As well as the general rationalisation
> aspect, between this and the probe-deferral changes in 4.12, we should
> now be able to rely on the presence of a group unambiguously indicating
> whether a given device is associated with an IOMMU or not.
> 
> Robin.
> 
> Robin Murphy (4):
>   iommu/msm: Add iommu_group support
>   iommu/tegra-smmu: Add iommu_group support
>   iommu/tegra-gart: Add iommu_group support
>   iommu: Finish making iommu_group support mandatory

Applied, thanks Robin.
