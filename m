From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 10 Jan 2017 15:09:24 +0100
Subject: [PATCH v7 00/19] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
In-Reply-To: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
Message-ID: <20170110140924.GC1318@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:45:51PM +0000, Eric Auger wrote:
> Eric Auger (17):
>   iommu: Rename iommu_dm_regions into iommu_resv_regions
>   iommu: Add a new type field in iommu_resv_region
>   iommu: iommu_alloc_resv_region
>   iommu: Only map direct mapped regions
>   iommu: iommu_get_group_resv_regions
>   iommu: Implement reserved_regions iommu-group sysfs file
>   iommu/vt-d: Implement reserved region get/put callbacks
>   iommu/amd: Declare MSI and HT regions as reserved IOVA regions
>   iommu/arm-smmu: Implement reserved region get/put callbacks
>   iommu/arm-smmu-v3: Implement reserved region get/put callbacks

IOMMU patches look good, what is the plan to merge this? I'd like to
take the IOMMU patches and can provide a branch for someone else to base
the rest on.


	Joerg
