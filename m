From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 27 May 2015 14:31:37 +0900
Subject: [v4 4/4] arm: kvm: add stub implementation for kvm_cpu_reset()
In-Reply-To: <55643EA4.4080206@arm.com>
References: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
 <1431047884-5637-5-git-send-email-takahiro.akashi@linaro.org>
 <55643EA4.4080206@arm.com>
Message-ID: <556556B9.7070607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2015 06:36 PM, Marc Zyngier wrote:
> On 08/05/15 02:18, AKASHI Takahiro wrote:
>> Just to avoid compiling errors on arm.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm/include/asm/kvm_asm.h  |    1 +
>>   arch/arm/include/asm/kvm_host.h |   12 ++++++++++++
>>   arch/arm/include/asm/kvm_mmu.h  |    5 +++++
>>   arch/arm/kvm/init.S             |    6 ++++++
>>   4 files changed, 24 insertions(+)
>>
(snip)
>
> So before this patch, KVM is broken on ARM. This is not acceptable.
> Please merge it with patch #1.

OK.

-Takahiro AKASHI


> Thanks,
>
> 	M.
>
