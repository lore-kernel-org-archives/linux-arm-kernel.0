From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 6 Jan 2017 12:02:42 +0100
Subject: [PATCH v6 00/18] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
In-Reply-To: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
Message-ID: <20170106110242.GN17255@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 07:04:28PM +0000, Eric Auger wrote:
>   iommu/dma: Allow MSI-only cookies
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

The iommu changes look mostly good to me. I posted a few comments to
individual patches.



	Joerg
