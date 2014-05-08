From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 May 2014 13:22:33 +0200
Subject: [PATCH resend 00/15] arm64 crypto roundup
In-Reply-To: <20140507144554.GC17253@arm.com>
References: <1398959381-8126-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140507144554.GC17253@arm.com>
Message-ID: <CAKv+Gu-sLaDJxFcvXwD93qdzyTuPCNL0DXbRp2BKb8U=8Q8c2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2014 16:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, May 01, 2014 at 04:49:32PM +0100, Ard Biesheuvel wrote:
>> This is a repost of the arm64 crypto patches that I have posted to the LAKML
>> over the past months. They have now been verified on actual hardware
>> (Cortex-A57) so if there are no remaining issues I would like to propose them
>> for 3.16.
>>
>> Ard Biesheuvel (15):
>>   asm-generic: allow generic unaligned access if the arch supports it
>>   arm64: add abstractions for FPSIMD state manipulation
>>   arm64: defer reloading a task's FPSIMD state to userland resume
>>   arm64: add support for kernel mode NEON in interrupt context
>>   arm64/crypto: SHA-1 using ARMv8 Crypto Extensions
>>   arm64/crypto: SHA-224/SHA-256 using ARMv8 Crypto Extensions
>>   arm64/crypto: GHASH secure hash using ARMv8 Crypto Extensions
>>   arm64/crypto: AES using ARMv8 Crypto Extensions
>>   arm64/crypto: AES in CCM mode using ARMv8 Crypto Extensions
>>   arm64: pull in <asm/simd.h> from asm-generic
>>   arm64/crypto: AES-ECB/CBC/CTR/XTS using ARMv8 NEON and Crypto
>>     Extensions
>>   arm64/crypto: add shared macro to test for NEED_RESCHED
>>   arm64/crypto: add voluntary preemption to Crypto Extensions SHA1
>>   arm64/crypto: add voluntary preemption to Crypto Extensions SHA2
>>   arm64/crypto: add voluntary preemption to Crypto Extensions GHASH
>
> There are about 5 patches that make sense to me ;) and apart from a few
> minor comments they look fine.
>
> There are the other 10 crypto patches that are beyond my knowledge. Do
> you know anyone who could do a sanity check on them? Are there any tests
> that would show the correctness of the implementation?
>

I will re-send the 3 FPSIMD patches separately with your review
comments addressed.

-- 
Ard.
