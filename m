From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Jan 2018 12:10:38 +0000
Subject: [PATCH v2 16/16] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP
 hardening support
In-Reply-To: <CAKv+Gu-8vjgq1ihfoTC5b1H4gsqAKzciyCXFDsW0e1dBcpZLdQ@mail.gmail.com>
References: <20180129174559.1866-1-marc.zyngier@arm.com>
 <20180129174559.1866-17-marc.zyngier@arm.com>
 <CAKv+Gu-8vjgq1ihfoTC5b1H4gsqAKzciyCXFDsW0e1dBcpZLdQ@mail.gmail.com>
Message-ID: <27fb84a6-d2a0-2d49-0e99-4a8bb8b32ac9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/01/18 19:41, Ard Biesheuvel wrote:
> On 29 January 2018 at 17:45, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Add the detection and runtime code for ARM_SMCCC_ARCH_WORKAROUND_1.
>> It is lovely. Really.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_psci.h | 63 ++++++++++++++++++++++++++++++++++++
>>  arch/arm64/kernel/bpi.S           | 20 ++++++++++++
>>  arch/arm64/kernel/cpu_errata.c    | 68 ++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 150 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/include/asm/kvm_psci.h
>>
>> diff --git a/arch/arm64/include/asm/kvm_psci.h b/arch/arm64/include/asm/kvm_psci.h
> 
> Did you mean to add this file? It is mostly identical to include/kvm/arm_psci.h

No, that's yet another patch splitting mistake. I'll drop it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
