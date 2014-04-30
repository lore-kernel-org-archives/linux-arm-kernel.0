From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Apr 2014 10:56:41 +0100
Subject: [PATCH v11 00/12] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
In-Reply-To: <20140429194416.GC3003@lvm>
References: <1398750865-10892-1-git-send-email-anup.patel@linaro.org>
 <20140429194416.GC3003@lvm>
Message-ID: <5360C8D9.1030906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/14 20:44, Christoffer Dall wrote:
> On Tue, Apr 29, 2014 at 11:24:13AM +0530, Anup Patel wrote:
>> Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
>> and Coordination Interface (PSCI) v0.1.
>>
>> This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
>> such that it does not break current KVM ARM/ARM64 ABI.
>>
>> The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
>> KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
>> PSCI v0.2 to VCPUs.
>>
> 
> I feel like this is ready to queue for the next merge window.  Last
> chance to object.

Looks OK to me.

	M.
-- 
Jazz is not dead. It just smells funny...
