From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 20 May 2016 17:04:35 +0530
Subject: [RFC 0/9] IOMMU probe deferral support
References: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
 <f192d4a0-9e13-4ae2-d3da-058e2e092634@samsung.com>
Message-ID: <001701d1b28b$9941ce40$cbc56ac0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin/Laurent,

>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Marek Szyprowski
>> Sent: Thursday, May 12, 2016 6:23 PM
>> To: Sricharan R <sricharan@codeaurora.org>; will.deacon at arm.com;
>> robin.murphy at arm.com; joro at 8bytes.org; iommu at lists.linux-
>> foundation.org; linux-arm-kernel at lists.infradead.org;
>> laurent.pinchart at ideasonboard.com
>> Subject: Re: [RFC 0/9] IOMMU probe deferral support
>>
>> Hello,
>>
>>
>> On 2016-04-25 17:58, Sricharan R wrote:
>> > This is mostly a repost of the probe deferral series from Laurent
>> > Pinchart [1]. Added a check to fix boot with ACPI.
>> > Adapted arm-smmu driver to work with deferred probing and added a new
>> > api for the below reason. This is based on the generic iommu binding
>> > series from Robin Murphy <robin.murphy@arm.com>.
>>
>> Thanks for this patchset. I'm working on some serious rework in exynos
>> power domains and clocks support code and it turned out that I need this
>> feature to resolve probing order. It works fine on my internal tree, where
>> some iommu controllers cannot get their clocks early enough.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>   Thanks for testing. So the issue that I was facing also was the same where the iommu
>   controllers cannot get clocks early. So waiting for some suggestions if this is right/
>   or there is another way for doing this probe deferral?

So wanted to ask what will be approach to have the probe deferral working.
I remember that you mentioned last time that you were going to visit this. Hence thought
of asking how to proceed on this ?

Regards,
 Sricharan
