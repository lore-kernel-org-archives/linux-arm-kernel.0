From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Jul 2013 13:56:46 +0100
Subject: [PATCH V4] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene
 host
In-Reply-To: <CAAhSdy29wvVcmwaUh5PfJTrw4R+MeDrLoWWOPwpnhw2hDvKmKg@mail.gmail.com>
References: <1374471119-26461-1-git-send-email-anup.patel@linaro.org>
 <CAAhSdy29wvVcmwaUh5PfJTrw4R+MeDrLoWWOPwpnhw2hDvKmKg@mail.gmail.com>
Message-ID: <51F7B80E.3040905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/13 12:57, Anup Patel wrote:
> On Mon, Jul 22, 2013 at 11:01 AM, Anup Patel <anup.patel@linaro.org> wrote:
>> This patch allows us to have X-Gene guest VCPU when using KVM arm64
>> on APM X-Gene host.
>>
>> We add KVM_ARM_TARGET_XGENE_POTENZA for X-Gene Potenza compatible
>> guest VCPU and we return KVM_ARM_TARGET_XGENE_POTENZA in kvm_target_cpu()
>> when running on X-Gene host with Potenza core.

[...]

> Hi Marc,
> 
> Do you think more changes are required to this patch ?

Hi Anup,

It looks OK to me as it is. I'll queue it for 3.12.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
