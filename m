From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Jan 2013 16:50:11 +0100
Subject: [PATCH v5 01/12] KVM: ARM: Introduce
 =?UTF-8?Q?KVM=5FSET=5FDEVICE=5FA?= =?UTF-8?Q?DDRESS=20ioctl?=
In-Reply-To: <13B0CEB2-8D36-48AE-BE0E-02D6231052CF@suse.de>
References: <CANM98qL=tisS_6rqPYHvo+xJUfC_WzypHABK2H_Ac+4Sqwb3-A@mail.gmail.com>
 <1357687783.10453.9@snotra>
 <CANM98q+=5gZ+=muw4UHy5hQ8D6zqz--BLa4Z0C39dnUxeCOWfA@mail.gmail.com>
 <9D32C496-91DE-44FC-BB1A-305BCE4A90CD@suse.de>
 <CAFEAcA99j=9dVz1YwZPZJ5tXR7ODQ4rZN_vfN046Bf7Yc1SQKg@mail.gmail.com>
 <86D3D406-05C3-4569-AD03-3223B46D47D9@suse.de>
 <CAFEAcA9z+kaSpVU3c8dWDHEnuGEri1JRZeS2+F5d2EefnX0oyQ@mail.gmail.com>
 <2ebf41d65170b9534c54c0c5f91a4b99@localhost>
 <13B0CEB2-8D36-48AE-BE0E-02D6231052CF@suse.de>
Message-ID: <0c1e99864fe87de92aa86a70504b9f73@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jan 2013 16:28:03 +0100, Alexander Graf <agraf@suse.de> wrote:
> On 09.01.2013, at 16:22, Marc Zyngier wrote:
> 
>> On Wed, 9 Jan 2013 15:11:39 +0000, Peter Maydell
>> <peter.maydell@linaro.org>
>> wrote:
>>> On 9 January 2013 14:58, Alexander Graf <agraf@suse.de> wrote:
>>>> 
>>>> Yeah, that was the basic idea. Considering that the patch set hasn't
>>>> been going
>>>> in for another 2 months after that discussion indicates that this
isn't
>>>> too much of
>>>> an issue though :).
>>> 
>>> We might get there faster if people didn't keep nitpicking the APIs at
>> the
>>> last minute :-)
>> 
>> Exactly. We're trying hard to get the damned thing merged, and the
>> permanent API churn quickly becomes a burden.
> 
> As I said earlier, we have had a lot of experience in creating really
bad
> APIs in the past.

Is this one really bad? Again, what changed in the meantime that makes you
think this API is wrong?

> But how about making this one specific? Call it
KVM_ARM_SET_VGIC_ADDRESS,
> keep the rest as it is, resend it, and later we can come up with an
> actually generic interface.

Let's pretend you never wrote that, shall we? ;-)

        M.
-- 
Fast, cheap, reliable. Pick two.
