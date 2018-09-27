From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Sep 2018 17:22:38 +0200
Subject: [PATCH v3 0/9] add support for relative references in jump tables
In-Reply-To: <20180919130803.GH24124@hirez.programming.kicks-ass.net>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
 <20180919130803.GH24124@hirez.programming.kicks-ass.net>
Message-ID: <CAKv+Gu9NB8B0GrD0GZfF5mcgg4epokEBLFuSLz-1KQo=yh0d8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 September 2018 at 15:08, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Sep 18, 2018 at 11:51:35PM -0700, Ard Biesheuvel wrote:
>
>> Ard Biesheuvel (8):
>>   kernel/jump_label: abstract jump_entry member accessors
>>   kernel/jump_label: implement generic support for relative references
>>   arm64/kernel: jump_label: switch to relative references
>>   x86: add support for 64-bit place relative relocations
>>   x86: jump_label: switch to jump_entry accessors
>>   x86/kernel: jump_table: use relative references
>>   jump_label: annotate entries that operate on __init code earlier
>>   jump_table: move entries into ro_after_init region
>>
>> Heiko Carstens (1):
>>   s390/jump_label: switch to relative references
>
> This all looks good to me;
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Ingo, could you queue this?

I wouldn't mind if these could go in for the next cycle if there are
no remaining concerns.

Thanks,
Ard.
