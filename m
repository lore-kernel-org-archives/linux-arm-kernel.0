From: yocto6@gmail.com (Nicholas Krause)
Date: Tue, 23 Sep 2014 11:30:04 -0400
Subject: FIX Me in pgtable.h
In-Reply-To: <542179BD.9070406@samsung.com>
References: <54216FC9.5060605@gmail.com>
	<542179BD.9070406@samsung.com>
Message-ID: <CAAxn8Jnz2CJJmp6Pc2ctRVgTSi=W203EvhAshDq-WK9fM4JR+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't have any hardware to test this over, however I can emulate a
arm system over qemu if needed.
I was just trying to help out if we need hardware I can't test and
again I am sorry for the terrible patches.
It was never my goal to be a nuisance.
Nick
On Tue, Sep 23, 2014 at 9:46 AM, Krzysztof Koz?owski
<k.kozlowski@samsung.com> wrote:
> On 23.09.2014 15:04, nick wrote:
>>
>> Greetings Arm Maintainers,
>> I am wondering about the fix me in pgtable.h for define kern_addr_valid
>> and how to set it to a correct
>> value as you state that this needs to be fixed as the defined macro is
>> still 1. This is probably incorrect
>> and should be changed.
>
>
> Dear Nick Krause,
>
> Before you start coding - do you have necessary ARM-based hardware to test
> your changes?
>
> Changing email won't remove LKML archives...
>
> Best regards,
> Krzysztof
>
