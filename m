From: cpandya@codeaurora.org (Chintan Pandya)
Date: Tue, 12 Jun 2018 12:17:11 +0530
Subject: [PATCH v13 0/3] Fix issues with huge mapping in ioremap for ARM64
In-Reply-To: <20180606154520.GM6631@arm.com>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <20180606154520.GM6631@arm.com>
Message-ID: <f04347b6-efec-ad62-3376-b03c27a41c89@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 6/6/2018 9:15 PM, Will Deacon wrote:

[...]

> On Wed, Jun 06, 2018 at 12:31:18PM +0530, Chintan Pandya wrote:
>> This series of patches re-bring huge vmap back for arm64.
>>
>> Patch 1/3 has been taken by Toshi in his series of patches
>> by name "[PATCH v3 0/3] fix free pmd/pte page handlings on x86"
>> to avoid merge conflict with this series.
>>

[...]

> 
>>   arch/arm64/include/asm/tlbflush.h |  7 ++++++
>>   arch/arm64/mm/mmu.c               | 48 +++++++++++++++++++++++++++++++++++----
>>   arch/x86/mm/pgtable.c             |  8 ++++---
>>   include/asm-generic/pgtable.h     |  8 +++----
>>   lib/ioremap.c                     |  4 ++--
> 
> If you get an ack from the x86 folks, then I could take all of this via
> arm64. Alternatively, now that I've reviewed the series this could happily
> go via another tree (e.g. akpm).
> 

Would you be able to take a look at this series ?
- 1/3 has been reviewed by Will and Toshi (as it touches arm64 and x86).
- 2/3 & 3/3 are arm64 specific changes.

If you think to take these patches, great ! Otherwise, I will try to
reach-out to x86 folks for their ack.

> Thanks,
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
