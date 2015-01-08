From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 8 Jan 2015 17:46:52 -0500
Subject: [PATCH v3 3/4] of/pci: add of_pci_dma_configure() update dma
 configuration
In-Reply-To: <2057344.eJYxBNosJg@wuerfel>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com>
 <20150108160626.GN11583@arm.com> <54AEDFED.8060008@ti.com>
 <2057344.eJYxBNosJg@wuerfel>
Message-ID: <54AF08DC.3000302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2015 05:25 PM, Arnd Bergmann wrote:
> On Thursday 08 January 2015 14:52:13 Murali Karicheri wrote:
>>
>> Could you add this as as a follow up patch as I don't have a platformm
>> that support IOMMU and as such my understanding of the IOMMU is limited?
>>
>> I can help test the change to make sure it has no side effect on
>> Keystone that doesn't support IOMMU.
>
> I think that's fine. Let's get your series done first and add the
> DMA aliases for iommus on top once we have worked out what to do.
>
> 	Arnd
Ok.

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
