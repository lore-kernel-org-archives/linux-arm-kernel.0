From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 15 Jun 2015 12:08:41 -0700
Subject: [PATCH] arm64: KVM: Optimize arm64 guest exit VFP/SIMD register
 save/restore
In-Reply-To: <557F1EC0.6060004@arm.com>
References: <557CACC4.8040405@samsung.com> <557EA23D.4090200@arm.com>
 <557F13A5.9030603@samsung.com> <557F1765.8040405@arm.com>
 <557F1CFB.8040106@samsung.com> <557F1EC0.6060004@arm.com>
Message-ID: <557F22B9.9020902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2015 11:51 AM, Marc Zyngier wrote:
> On 15/06/15 19:44, Mario Smarduch wrote:
>> On 06/15/2015 11:20 AM, Marc Zyngier wrote:
>>> On 15/06/15 19:04, Mario Smarduch wrote:
>>>> On 06/15/2015 03:00 AM, Marc Zyngier wrote:
>>>>> Hi Mario,
>>>>>
[...]
>>>
>>> The 32bit code is starting to show its age, and could probably do with a
>>> refactor. If you have some cycles to spare, that'd be quite interesting.
>>
>> Yep, will do, ARMv7 is still very relevant.
> 
> You bet it is. My home router is a v7 VM...
> 
> 	M.
> 
Definitely nice use case, another one RPi2 appears like
everyone is hacking on it :)
