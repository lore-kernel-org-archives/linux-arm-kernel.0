From: yocto6@gmail.com (nick)
Date: Wed, 24 Sep 2014 07:38:15 -0400
Subject: FIX Me in pgtable.h
In-Reply-To: <542238CF.30505@codeaurora.org>
References: <54216FC9.5060605@gmail.com> <542238CF.30505@codeaurora.org>
Message-ID: <5422AD27.30101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14-09-23 11:21 PM, Laura Abbott wrote:
> On 9/23/2014 6:04 AM, nick wrote:
>> Greetings Arm Maintainers,
>> I am wondering about the fix me in pgtable.h for define kern_addr_valid and how to set it to a correct
>> value as you state that this needs to be fixed as the defined macro is still 1. This is probably incorrect
>> and should be changed.
>> Thanks,
>> Nick
>>
> 
> It's not clear to me how valuable fixing kern_addr_valid would actually
> be for arm. It seems to be used in exactly one place, fs/proc/kcore.c
> and the associated Kconfig is explicitly marked if !ARM. Nearly all
> other archs minus x86, arm64 and sparc are in the same boat as well.
> 
> Thanks,
> Laura
> 
Laura,
Can we remove it then as it seems that it's not needed at all.
Cheers Nick 
