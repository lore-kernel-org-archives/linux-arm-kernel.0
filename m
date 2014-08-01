From: behanw@converseincode.com (Behan Webster)
Date: Thu, 31 Jul 2014 21:11:59 -0700
Subject: [PATCH 0/4] LLVMLinux: Patches to enable the kernel to be compiled
 with clang/LLVM
In-Reply-To: <20140731103323.GL26853@arm.com>
References: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
 <20140731103323.GL26853@arm.com>
Message-ID: <53DB138F.7070709@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/14 03:33, Will Deacon wrote:
> On Thu, Jul 31, 2014 at 12:57:25AM +0100, behanw at converseincode.com wrote:
>> From: Behan Webster <behanw@converseincode.com>
>>
>> This patch set moves from using locally defined named registers to access the
>> stack pointer to using a globally defined named register. This allows the code
>> to work both with gcc and clang.
>>
>> The LLVMLinux project aims to fully build the Linux kernel using both gcc and
>> clang (the C front end for the LLVM compiler infrastructure project).
>>
>> Behan Webster (4):
>>    arm64: LLVMLinux: Add current_stack_pointer() for arm64
>>    arm64: LLVMLinux: Use current_stack_pointer in save_stack_trace_tsk
>>    arm64: LLVMLinux: Calculate current_thread_info from
>>      current_stack_pointer
>>    arm64: LLVMLinux: Use current_stack_pointer in kernel/traps.c
> Once Andreas's comments have been addressed:
>
>    Acked-by: Will Deacon <will.deacon@arm.com>
>
> Please can you send a new series after the merge window?
Pity. I was hoping to get it in this merge window.

However, will resubmit for 3.18.

Thanks,

Behan

-- 
Behan Webster
behanw at converseincode.com
