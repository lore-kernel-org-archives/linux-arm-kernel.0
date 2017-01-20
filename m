From: sricharan@codeaurora.org (Sricharan)
Date: Sat, 21 Jan 2017 00:50:03 +0530
Subject: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing
 workarounds
In-Reply-To: <20170119161826.GI31594@arm.com>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
 <1484838356-24962-9-git-send-email-sricharan@codeaurora.org>
 <20170119161826.GI31594@arm.com>
Message-ID: <000001d27352$37b5cea0$a7216be0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

>-----Original Message-----
From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-owner at vger.kernel.org] On Behalf Of Will Deacon
>Sent: Thursday, January 19, 2017 9:48 PM
>To: Sricharan R <sricharan@codeaurora.org>
>Cc: robin.murphy at arm.com; joro at 8bytes.org; lorenzo.pieralisi at arm.com; iommu at lists.linux-foundation.org; linux-arm-
>kernel at lists.infradead.org; linux-arm-msm at vger.kernel.org; m.szyprowski at samsung.com
>Subject: Re: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing workarounds
>
>On Thu, Jan 19, 2017 at 08:35:52PM +0530, Sricharan R wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Now that the appropriate ordering is enforced via profe-deferral of
>> masters in core code, rip it all out and bask in the simplicity.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> [Sricharan: Rebased on top of ACPI IORT SMMU series]
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  * No change
>>
>>  drivers/iommu/arm-smmu-v3.c | 46 ++---------------------------------
>>  drivers/iommu/arm-smmu.c    | 58 +++++++--------------------------------------
>>  2 files changed, 10 insertions(+), 94 deletions(-)
>
>Acked-by: Will Deacon <will.deacon@arm.com>
>
>I can't wait to see this series merged. What's the plan for that?

Thanks. Posted V6 with your tags and comments for V5 addressed.

Regards,
 Sricharan
