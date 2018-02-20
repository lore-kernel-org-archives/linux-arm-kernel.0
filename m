From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 20 Feb 2018 11:28:16 +0000
Subject: [PATCH 11/37] dt-bindings: document stall and PASID properties
 for IOMMU masters
In-Reply-To: <20180219025107.v3f3eapukupm7g5j@rob-hp-laptop>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-12-jean-philippe.brucker@arm.com>
 <20180219025107.v3f3eapukupm7g5j@rob-hp-laptop>
Message-ID: <82037ff9-c786-8769-81fc-300e48ee4156@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/18 02:51, Rob Herring wrote:
[...]
>> +- pasid-bits: Some masters support multiple address spaces for DMA, by
>> +  tagging DMA transactions with an address space identifier. By default,
>> +  this is 0, which means that the device only has one address space.
> 
> So 3 would mean 8 address spaces?

Yes

> Maybe pasid-num-bits would be a bit clearer. Either way,

Indeed, I'll change it

> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks!
Jean
