From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 14 Oct 2015 13:41:05 +0100
Subject: [PATCHv3 01/11] arm64: Move swapper pagetable definitions
In-Reply-To: <20151014114247.GA2150@leverpostej>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-2-git-send-email-suzuki.poulose@arm.com>
 <20151014114247.GA2150@leverpostej>
Message-ID: <561E4D61.7000000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 12:42, Mark Rutland wrote:
> On Wed, Oct 14, 2015 at 12:20:24PM +0100, Suzuki K. Poulose wrote:

>>
>> Also renames the symbols to prevent conflicts. e.g,
>>   	BLOCK_SHIFT => SWAPPER_BLOCK_SHIFT
>
> This sounds sensible to be, so FWIW:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> I have a couple of minor nits below, though.

>> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
>> new file mode 100644
>> index 0000000..622929d
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kernel-pgtable.h
>> @@ -0,0 +1,65 @@
>> +/*
>> + * asm/kernel-pgtable.h : Kernel page table mapping
>
> Drop the filename from the comment. It's redundant and ends up being
> painful when refactoring and moving things around.
>

OK

>> +
>> +
>> +#endif
>
> It would be nice to have the usual comment here for what this is ending,
> i.e.
>
> #endif /* __ASM_KERNEL_PGTABLE_H */

Oh yes, will add it.

Thanks
Suzuki
