From: anup.patel@linaro.org (Anup Patel)
Date: Thu, 14 Nov 2013 19:15:53 +0530
Subject: [PATCH V4] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene
 host
In-Reply-To: <52849E87.3010109@arm.com>
References: <1374471119-26461-1-git-send-email-anup.patel@linaro.org>
 <CAAhSdy29wvVcmwaUh5PfJTrw4R+MeDrLoWWOPwpnhw2hDvKmKg@mail.gmail.com>
 <51F7B80E.3040905@arm.com>
 <CALrVBkt3eBM4hJ7W0orgdS9O=dU26Mb8Fd0Q+wozV87YZQjEHw@mail.gmail.com>
 <CALrVBkt+qMDcemR62ZgH88AsXUKDVWpz-Uf3JKJt6XoQh_dvXw@mail.gmail.com>
 <52849E87.3010109@arm.com>
Message-ID: <CALrVBkuTQYWPYLxr51WVouWAmB-xc1cLE4TZVapPW5OpN53ndQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 November 2013 15:27, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 14/11/13 04:27, Anup Patel wrote:
>> On 9 November 2013 10:32, Anup Patel <anup.patel@linaro.org> wrote:
>>> On 30 July 2013 18:26, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> On 30/07/13 12:57, Anup Patel wrote:
>>>>> On Mon, Jul 22, 2013 at 11:01 AM, Anup Patel <anup.patel@linaro.org> wrote:
>>>>>> This patch allows us to have X-Gene guest VCPU when using KVM arm64
>>>>>> on APM X-Gene host.
>>>>>>
>>>>>> We add KVM_ARM_TARGET_XGENE_POTENZA for X-Gene Potenza compatible
>>>>>> guest VCPU and we return KVM_ARM_TARGET_XGENE_POTENZA in kvm_target_cpu()
>>>>>> when running on X-Gene host with Potenza core.
>>>>
>>>> [...]
>>>>
>>>>> Hi Marc,
>>>>>
>>>>> Do you think more changes are required to this patch ?
>>>>
>>>> Hi Anup,
>>>>
>>>> It looks OK to me as it is. I'll queue it for 3.12.
>>>
>>> Hi Marc,
>>>
>>> I think this patch was missed for 3.12
>>>
>>> Do you want me to resend this patch ??
>>
>> Hi Marc,
>>
>> What is missing in this patch ??
>>
>> Do you want me to resend this patch ??
>
> I appear to have misplaced it somehow.
> Please resend it .

I have rechecked this patch against latest Linux stable
tree. It still applies on latest Linux stable tree hence
no need to re-base this patch on latest code.

Please get the patch from this mail thread itself.

Is it possible to merge this patch for 3.13 ??

Regards,
Anup

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
