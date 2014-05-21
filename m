From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Wed, 21 May 2014 11:08:48 +0530
Subject: [PATCH 1/1] arm64: tlbflush.h: Clean up comment
In-Reply-To: <CAKZGPAMhZZoSAs0LPpGJijCL3EM-ANoSWs0-yQPX2yL=nB-6DQ@mail.gmail.com>
References: <1400645600-35973-1-git-send-email-ritesh.harjani@gmail.com>
 <1400645600-35973-2-git-send-email-ritesh.harjani@gmail.com>
 <CAKZGPAMhZZoSAs0LPpGJijCL3EM-ANoSWs0-yQPX2yL=nB-6DQ@mail.gmail.com>
Message-ID: <CAD15agYEm3iUPEeA78cqd1tyfNz+ZFWXg57RP9M0ZBPiNDHg2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok thanks Arun,

I didnt see this patch
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252837.html

Will submit the correct patch then.

Thanks
Ritesh


On Wed, May 21, 2014 at 9:52 AM, Arun KS <arunks.linux@gmail.com> wrote:
> Hi Ritesh,
>
> On Wed, May 21, 2014 at 9:43 AM,  <ritesh.harjani@gmail.com> wrote:
>> From: Ritesh Harjani <ritesh.harjani@gmail.com>
>>
>> Clean up the undefined function name(flush_kern_tlb_page)
>> from the comment in tlbflush.h
>>
>> Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 8b48203..85e4f98 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -63,12 +63,6 @@ extern struct cpu_tlb_fns cpu_tlb;
>>   *             - vaddr - virtual address (may not be aligned)
>>   *             - vma   - vma_struct describing address range
>>   *
>> - *     flush_kern_tlb_page(kaddr)
>> - *
>> - *             Invalidate the TLB entry for the specified page.  The address
>> - *             will be in the kernels virtual memory space.  Current uses
>> - *             only require the D-TLB to be invalidated.
>> - *             - kaddr - Kernel virtual memory address
>>   */
>>  static inline void flush_tlb_all(void)
>
> Probably you can remove the following comment in same file as well.
> "The arch/arm64/mm/tlb.S files implement these methods."
>
> arch/arm64/mm/tlb.S file is no more and all the methods are
> implemented in the current file.
>
> Thanks,
> Arun
>
>>  {
>> --
>> 1.8.1.3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
