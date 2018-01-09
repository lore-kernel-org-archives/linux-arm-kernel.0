From: mbrugger@suse.com (Matthias Brugger)
Date: Tue, 9 Jan 2018 15:07:28 +0100
Subject: [PATCH v3 00/13] arm64 kpti hardening and variant 2 workarounds
In-Reply-To: <20180108185353.sung5ovk65au3kge@armageddon.cambridge.arm.com>
References: <1515432758-26440-1-git-send-email-will.deacon@arm.com>
 <20180108185353.sung5ovk65au3kge@armageddon.cambridge.arm.com>
Message-ID: <904afc66-7936-d430-f056-6aa6e64ca0a9@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 01/08/2018 07:53 PM, Catalin Marinas wrote:
> On Mon, Jan 08, 2018 at 05:32:25PM +0000, Will Deacon wrote:
>> Jayachandran C (1):
>>   arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
>>
>> Marc Zyngier (3):
>>   arm64: Move post_ttbr_update_workaround to C code
>>   arm64: KVM: Use per-CPU vector when BP hardening is enabled
>>   arm64: KVM: Make PSCI_VERSION a fast path
>>
>> Shanker Donthineni (1):
>>   arm64: Implement branch predictor hardening for Falkor
>>
>> Will Deacon (8):
>>   arm64: use RET instruction for exiting the trampoline
>>   arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
>>   arm64: Take into account ID_AA64PFR0_EL1.CSV3
>>   arm64: cpufeature: Pass capability structure to ->enable callback
>>   drivers/firmware: Expose psci_get_version through psci_ops structure
>>   arm64: Add skeleton to harden the branch predictor against aliasing
>>     attacks
>>   arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
>>   arm64: Implement branch predictor hardening for affected Cortex-A CPUs
> 
> I'm queuing these into the arm64 for-next/core (after some overnight
> testing). Any additional fixes should be done on top.
> 

I see these patches are not yet pushed to:
git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

Did you hit any problems in the overnight tests?

Regards,
Matthias
