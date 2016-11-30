From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 30 Nov 2016 10:41:10 +0100
Subject: [RFC v3 04/10] iommu: iommu_alloc_resv_region
In-Reply-To: <20161129161128.GI2078@8bytes.org>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <1479215363-2898-5-git-send-email-eric.auger@redhat.com>
 <20161129161128.GI2078@8bytes.org>
Message-ID: <8f19730c-3a30-00ba-db5d-4ce2ffb32668@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 29/11/2016 17:11, Joerg Roedel wrote:
> On Tue, Nov 15, 2016 at 01:09:17PM +0000, Eric Auger wrote:
>> +static inline struct iommu_resv_region *
>> +iommu_alloc_resv_region(phys_addr_t start, size_t length, unsigned int prot)
>> +{
>> +	return NULL;
>> +}
>> +
> 
> Will this function be called outside of iommu code?

No the function is not bound to be called outside of the iommu code. I
will remove this.

Thanks

Eric
> 
> 
> 
> 	Joerg
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
