From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 20 Jan 2017 12:02:13 +0530
Subject: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing
 workarounds
In-Reply-To: <b3f0f112-e4a0-fa4d-4f18-44484392a5e9@arm.com>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
 <1484838356-24962-9-git-send-email-sricharan@codeaurora.org>
 <20170119165053.GC28483@red-moon>
 <b3f0f112-e4a0-fa4d-4f18-44484392a5e9@arm.com>
Message-ID: <001101d272e6$f365b820$da312860$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

>-----Original Message-----
From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-owner at vger.kernel.org] On Behalf Of Robin Murphy
>Sent: Thursday, January 19, 2017 11:28 PM
>To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Sricharan R <sricharan@codeaurora.org>
>Cc: will.deacon at arm.com; joro at 8bytes.org; iommu at lists.linux-foundation.org; linux-arm-kernel at lists.infradead.org; linux-arm-
>msm at vger.kernel.org; m.szyprowski at samsung.com 
>Subject: Re: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing workarounds
>
>On 19/01/17 16:50, Lorenzo Pieralisi wrote:
>> On Thu, Jan 19, 2017 at 08:35:52PM +0530, Sricharan R wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>>
>>> Now that the appropriate ordering is enforced via profe-deferral of
>>> masters in core code, rip it all out and bask in the simplicity.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> [Sricharan: Rebased on top of ACPI IORT SMMU series]
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> ---
>>>  * No change
>>
>> Well, a tad too early on the series for ACPI, aka if we bisect the
>> series here you would break ACPI.
>>
>> Totally agree on the patch, but you should move it to the end of the
>> series.
>
>Indeed - I think a more appropriate ordering of the current patch
>numbers would be:
>
>1, 2, 3, 4, 9, 5+10 (squashed), 6, 11, 7, 8, 12
>

Ok, will repost with this order.

Regards,
 Sricharan
