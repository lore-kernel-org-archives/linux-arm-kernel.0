From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 15 Feb 2013 14:24:42 -0500
Subject: randconfig errors
In-Reply-To: <511E8AD9.2050507@arm.com>
References: <511E6FA4.2000709@gmail.com>
 <26e621467155fdb1626ecdac4e811deb@localhost>
 <c163151b4b855149ba57faa9a1a10c64@localhost>
 <CANM98qKEwFzccifq6oWzzS4Ot_iaznccr9_CcQLDGhj_puS-Aw@mail.gmail.com>
 <511E8AD9.2050507@arm.com>
Message-ID: <CANM98qL05vMYTZoM9un2=Sa+GsZFunn-S9XcXd0b8LB+vPKGBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 2:22 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 15/02/13 19:16, Christoffer Dall wrote:
>> On Fri, Feb 15, 2013 at 1:47 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On Fri, 15 Feb 2013 19:22:37 +0100, Marc Zyngier <marc.zyngier@arm.com>
>>> wrote:
>>>> On Fri, 15 Feb 2013 11:25:56 -0600, Rob Herring <robherring2@gmail.com>
>>>> wrote:
>>>>> Errors from randconfig builds restricted to multi-platform configs on
>>>>> the current linux-next. I know I've seen a fix on the first one from
>>>>> Arnd, but have not investigated any of these.
>>>>>
>>>>
>>>>>
>>>>
>>> /var/lib/jenkins/jobs/linux-randconfig/workspace/include/linux/kvm_host.h:333:34:
>>>>> error: 'KVM_USER_MEM_SLOTS' undeclared here (not in a function)
>>>>
>>>> This one comes from bbacc0c (KVM: Rename KVM_MEMORY_SLOTS ->
>>>> KVM_USER_MEM_SLOTS).
>>>> I'll queue a patch to fix the breakage...
>>>
>>> Looks like there's a few more, and what was brewing in kvm-next had some
>>> side effects.
>>>
>>> Christoffer, I'll send the patches separately.
>>>
>> I was kind of hoping that the KVM guys would have pulled the KVM/ARM
>> stuff into kvm/next and it could have been fixed up there.... The
>> patches are really trivial though iirc.
>
> Indeed they are. Probably an oversight from the KVM guys. Sent them
> anyway...
>
I saw them, it all looks good.

I'm cc'ing the kvm list here just for info.

-Christoffer
