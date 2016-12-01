From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 1 Dec 2016 09:58:19 +0000
Subject: [PATCH] arm64: dts: juno: Correct PCI IO window
In-Reply-To: <7823573.FNB8ayVOnQ@wuerfel>
References: <1480452310-29286-1-git-send-email-jeremy.linton@arm.com>
 <92ac8013-b88e-2f74-9a49-7d5f38a4e7a5@arm.com> <7823573.FNB8ayVOnQ@wuerfel>
Message-ID: <97ea1f58-00e9-c436-e9a5-7830aa7dbe6c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/11/16 22:51, Arnd Bergmann wrote:
> On Wednesday, November 30, 2016 4:29:35 PM CET Sudeep Holla wrote:
>> Hi Jeremy,
>>
>> On 29/11/16 20:45, Jeremy Linton wrote:
>>> The PCIe root complex on Juno translates the MMIO mapped
>>> at 0x5f800000 to the PIO address range starting at 0
>>> (which is common because PIO addresses are generally < 64k).
>>> Correct the DT to reflect this.
>>>
>>
>> I have another DT fix that I have asked ARM-SoC guys to pick up directly
>> from the list. If that doesn't happen, I will send PR including both.
>>
>> If that happens then we need to send this to them to be picked directly.
>> At this point I want to wait for couple of days to avoid confusion.
>
> I ended up taking the other one for v4.10, but this one seems more
> important so I applied it for v4.9.
>
> Let me know if you disagree with the priorities, as I plan to send out
> the last 4.9 fixes pull request to Linus tomorrow.
>

No that's fine.

-- 
Regards,
Sudeep
