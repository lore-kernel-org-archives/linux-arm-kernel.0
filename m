From: anup.patel@linaro.org (Anup Patel)
Date: Thu, 14 Nov 2013 09:57:15 +0530
Subject: [PATCH V4] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene
 host
In-Reply-To: <CALrVBkt3eBM4hJ7W0orgdS9O=dU26Mb8Fd0Q+wozV87YZQjEHw@mail.gmail.com>
References: <1374471119-26461-1-git-send-email-anup.patel@linaro.org>
 <CAAhSdy29wvVcmwaUh5PfJTrw4R+MeDrLoWWOPwpnhw2hDvKmKg@mail.gmail.com>
 <51F7B80E.3040905@arm.com>
 <CALrVBkt3eBM4hJ7W0orgdS9O=dU26Mb8Fd0Q+wozV87YZQjEHw@mail.gmail.com>
Message-ID: <CALrVBkt+qMDcemR62ZgH88AsXUKDVWpz-Uf3JKJt6XoQh_dvXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 November 2013 10:32, Anup Patel <anup.patel@linaro.org> wrote:
> On 30 July 2013 18:26, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 30/07/13 12:57, Anup Patel wrote:
>>> On Mon, Jul 22, 2013 at 11:01 AM, Anup Patel <anup.patel@linaro.org> wrote:
>>>> This patch allows us to have X-Gene guest VCPU when using KVM arm64
>>>> on APM X-Gene host.
>>>>
>>>> We add KVM_ARM_TARGET_XGENE_POTENZA for X-Gene Potenza compatible
>>>> guest VCPU and we return KVM_ARM_TARGET_XGENE_POTENZA in kvm_target_cpu()
>>>> when running on X-Gene host with Potenza core.
>>
>> [...]
>>
>>> Hi Marc,
>>>
>>> Do you think more changes are required to this patch ?
>>
>> Hi Anup,
>>
>> It looks OK to me as it is. I'll queue it for 3.12.
>
> Hi Marc,
>
> I think this patch was missed for 3.12
>
> Do you want me to resend this patch ??

Hi Marc,

What is missing in this patch ??

Do you want me to resend this patch ??

Regards,
Anup

>
> Regards,
> Anup
>
>>
>> Thanks,
>>
>>         M.
>> --
>> Jazz is not dead. It just smells funny...
>>
