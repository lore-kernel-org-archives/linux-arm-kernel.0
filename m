From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 29 Nov 2016 17:11:28 +0100
Subject: [RFC v3 04/10] iommu: iommu_alloc_resv_region
In-Reply-To: <1479215363-2898-5-git-send-email-eric.auger@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <1479215363-2898-5-git-send-email-eric.auger@redhat.com>
Message-ID: <20161129161128.GI2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 01:09:17PM +0000, Eric Auger wrote:
> +static inline struct iommu_resv_region *
> +iommu_alloc_resv_region(phys_addr_t start, size_t length, unsigned int prot)
> +{
> +	return NULL;
> +}
> +

Will this function be called outside of iommu code?



	Joerg
