From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 30 May 2017 11:58:50 +0100
Subject: [PATCH 2/7] dt-bindings: PCI: Describe ATS property for root
 complex nodes
In-Reply-To: <20170530100153.GI2818@8bytes.org>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
 <20170524180143.19855-3-jean-philippe.brucker@arm.com>
 <20170530100153.GI2818@8bytes.org>
Message-ID: <035be7ba-e850-a5a9-08fa-802a04feb600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/17 11:01, Joerg Roedel wrote:
> On Wed, May 24, 2017 at 07:01:38PM +0100, Jean-Philippe Brucker wrote:
>> +- ats-supported: if present, the root complex supports the Address
>> +  Translation Service (ATS). It is able to interpret the AT field in PCIe
>> +  Transaction Layer Packets, and forward Translation Completions or
>> +  Invalidation Requests to endpoints.
>> +
>> +  Device drivers should not enable ATS in endpoints unless this property
>> +  is present.
> 
> Device drivers should never enable ATS, this is the job of the IOMMU
> driver. This should be clarified in the text.

Right, I will change this.

Thanks,
Jean
