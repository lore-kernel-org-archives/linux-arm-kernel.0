From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 May 2018 10:49:17 +0100
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <1863838560.56771.1526636258081@email.1und1.de>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
 <307323036.63872.1526576126537@email.1und1.de>
 <20180517180758.GK12198@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1805171422450.8529@macbook-air>
 <alpine.DEB.2.21.1805171530080.8529@macbook-air>
 <0a643984-1586-8c56-6627-430f0c2a4ba8@gmail.com>
 <d6b6f632-2051-a239-3e44-4750f2ac89d5@arm.com>
 <1863838560.56771.1526636258081@email.1und1.de>
Message-ID: <6097533d-5c77-0bba-a974-53ff65663dd3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/18 10:37, Stefan Wahren wrote:
> Hi Marc,
> 
>> Marc Zyngier <marc.zyngier@arm.com> hat am 18. Mai 2018 um 10:07 geschrieben:
>>
>> I have a pretty simple series[1] which I used to profile 32bit guests on
>> an arm64 KVM host. Nobody really cared about it because running a 32bit
>> kernel on 64bit HW is a bit odd, to say the least, and I'm probably the
>> only one actually running 32bit VMs.
>>
>>> FWIW, Broadcom STB chips, even when 64-bit capable or often used with an
>>> 32-bit ARM kernel, so having the ARMv8 PMUs work under a 32-bit ARM
>>> kernel would be great. The downstream solution we have sued thus far is
>>> to find the closest compatible string to represent those, which is not
>>> great...
>> Ah, so you're *really* doing that? I'm not going to ask why, I'm scared
>> of the answer... ;-)
>>
>> Anyway, I can repost that series if that will prevent people from having
>> that kind of silly hacks.
> 
> yes please. But there is a minor nit: some patches introduce new files without SPDX tags.
I'm shocked! ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
