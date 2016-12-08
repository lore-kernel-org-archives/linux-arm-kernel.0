From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 8 Dec 2016 08:34:55 +0100
Subject: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
In-Reply-To: <165d4f72-ef74-2db8-166a-1f90208315c8@codeaurora.org>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <6c9012fd-070b-6218-48e7-69b37f2559dd@redhat.com>
 <20161130103713.GB2724@arm.com>
 <1899e46c-7b06-01d6-6cff-eb0985a4f11d@redhat.com>
 <165d4f72-ef74-2db8-166a-1f90208315c8@codeaurora.org>
Message-ID: <0bff7ad0-38f2-e2d0-0d19-3aa40e827244@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

On 07/12/2016 19:52, Shanker Donthineni wrote:
> Hi Eric,
> 
> Is there any reason why you are not supporting SMMUv3 driver? Qualcomm
> hardware doesn't not support SMMUv2 hardware, please add support for
> SMMUv3 in next patch set. I've ported ' RFC,v3,09/10] iommu/arm-smmu:
> Implement reserved region get/put callbacks' to SMMUv3 driver and tested
> device-pass-through feature on Qualcomm server platform without any issue.
> 
> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Thanks!

No reason behind not supporting smmuv3 except I don't have any HW to test.

I will add this support in next version.

Thanks

Eric
