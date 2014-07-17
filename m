From: behanw@converseincode.com (Behan Webster)
Date: Wed, 16 Jul 2014 21:17:43 -0700
Subject: [PATCH 0/6] LLVMLinux: Patches to enable the kernel to be compiled
 with clang/LLVM
In-Reply-To: <alpine.LFD.2.11.1407130508580.3647@knanqh.ubzr>
References: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
 <alpine.LFD.2.11.1407130508580.3647@knanqh.ubzr>
Message-ID: <53C74E67.9050401@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/14 02:10, Nicolas Pitre wrote:
> On Tue, 8 Jul 2014, behanw at converseincode.com wrote:
>
>> From: Behan Webster <behanw@converseincode.com>
>>
>> The LLVMLinux project aims to fully build the Linux kernel using both gcc and
>> clang (the C front end for the LLVM compiler infrastructure project).
>>
>> Clang only supports global named registers for non-allocatable registers like
>> the stack pointer. By centralizing the definition of current_stack_pointer, the
>> use of named registers for ARM remains largely unchanged while working for both
>> gcc and clang.
> You verified that the compiled code is identical on gcc?
Yes. Identical.

>    If so:
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
Thanks,

Behan

-- 
Behan Webster
behanw at converseincode.com
