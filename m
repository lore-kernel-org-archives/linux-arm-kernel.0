From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 28 Jul 2015 17:06:02 +0100
Subject: [Xen-devel] [PATCH 2/8] xen: Make clear that swiotlb and biomerge
 are dealing with DMA address
In-Reply-To: <55B7A526.30105@citrix.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-3-git-send-email-julien.grall@citrix.com>
 <55B7A526.30105@citrix.com>
Message-ID: <55B7A86A.6010001@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 28/07/15 16:52, David Vrabel wrote:
> On 28/07/15 16:02, Julien Grall wrote:
>>
>> +/* Pseudo-physical <-> DMA conversion */
>> +static inline unsigned long pfn_to_dfn(unsigned long pfn)
> 
> Use BFN for bus frame number.  This is the terminology that is used in
> the (proposed) pv-iommu hypercall.

Good idea, I will use them in the next version.

Regards,

-- 
Julien Grall
