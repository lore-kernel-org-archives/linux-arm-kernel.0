From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 22 Jul 2011 18:23:05 +0530
Subject: [PATCH] ARM: do not mark CPU 0 as hotpluggable
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203F2398D3A@dlee02.ent.ti.com>
References: <1311204745-6276-1-git-send-email-mturquette@ti.com>	<4E2796DA.80001@gmail.com>
	<4E27BA10.3060203@ti.com>	<20110721133033.GN26574@n2100.arm.linux.org.uk>
	<4E2902E7.6000108@ti.com>
	<13B9B4C6EF24D648824FF11BE896716203F2398D3A@dlee02.ent.ti.com>
Message-ID: <4E2972B1.5070604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/22/2011 6:15 PM, Woodruff, Richard wrote:
>
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
>> kernel-bounces at lists.infradead.org] On Behalf Of Shilimkar, Santosh
>
>>> With fixed IRQ migration and forcing CPU0 into an infinite WFI loop,
>>> I can offline CPU0 and still have a running system.
>>>
>> The secure software runs only on CPU0 and that's the biggest limitation.
>> Other issues like hand-shake as you pointed out, power sequencing etc
>> can be worked around.
>
> As you know well some of the secure APIs work on CPU1 and others do not.
>
> I notice in other thread Russell made assumption about CPU1 being able to use all because it could run some. This is not the case.
>
I clarified that on the other thread.

Regards
Santosh
