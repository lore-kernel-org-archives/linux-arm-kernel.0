From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 30 Oct 2013 17:02:35 -0500
Subject: [PATCH v2 4/6] edac: Document Krait L1/L2 EDAC driver binding
In-Reply-To: <52718118.1020009@codeaurora.org>
References: <1383164736-1849-1-git-send-email-sboyd@codeaurora.org>
 <1383164736-1849-5-git-send-email-sboyd@codeaurora.org>
 <872F86E8-85CE-472B-9546-CDCC96F6F08B@codeaurora.org>
 <52717EA5.6030208@codeaurora.org>
 <F38814D8-723E-4A41-839D-DEE351738017@codeaurora.org>
 <52718118.1020009@codeaurora.org>
Message-ID: <D081E03B-01D6-497F-B8D0-E994219C8282@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 30, 2013, at 4:58 PM, Stephen Boyd wrote:

> On 10/30/13 14:56, Kumar Gala wrote:
>> On Oct 30, 2013, at 4:48 PM, Stephen Boyd wrote:
>> 
>>> On 10/30/13 14:45, Kumar Gala wrote:
>>>> On Oct 30, 2013, at 3:25 PM, Stephen Boyd wrote:
>>>>> +l2-cache node containing the following properties:
>>>> Is the L1 interrupt not per core L1 cache (even if they are OR together at PIC)?
>>> Yes it is per CPU. That is what the 0xf part of the cpus interrupts
>>> property is showing.
>> Than why not have it in each cpu node?
> 
> Because that duplicates things unnecessarily? The cpus node can hold
> things that are common to all CPUs to avoid duplication. If it was a
> different PPI for each CPU then I would agree that we need to put it in
> each cpu node.

Ok, I'll accept that as the binding is specific to Krait (and I assume all SoCs w/Krait wire this up to a common interrupt)

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
