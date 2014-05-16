From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 16 May 2014 09:37:51 -0400
Subject: RCU stall on panda
In-Reply-To: <5375C145.6070904@linaro.org>
References: <53675C5F.10509@linaro.org>
 <20140505180617.GM8754@linux.vnet.ibm.com>
 <20140512212102.GF5668@atomide.com> <5371BD69.8010600@linaro.org>
 <20140513153220.GC16837@atomide.com> <53747E6D.60500@linaro.org>
 <53748371.5030704@linaro.org> <5374C07C.1070400@linaro.org>
 <20140515183247.GF23659@atomide.com> <5375091D.3010607@ti.com>
 <5375C145.6070904@linaro.org>
Message-ID: <537614AF.50100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 May 2014 03:41 AM, Alex Shi wrote:
> On 05/16/2014 02:36 AM, Santosh Shilimkar wrote:
>>>>>> yes.
>>>>>> My board is panda ES. without this revert, it works.
>>>>
>>>> Care to specify what linux version you are testing against?
>>>>
>>>> Does it hang in idle always immediately on booting?
>>>>
>>>> Or does the serial console first hang with sysrq still
>>>> working (ctrl-a h in minicom for help) with device
>>>> eventually locking up hard?
>>>>
>> I just posted an updated patch Alex on other thread.
>> Attaching here again for your reference. Please try
>> it out and see if the you still get a hang.
> 
> it does not hang this time.
>
This is good news and exactly what I expected.
 
> but I am not sure it can solve my problem, since RCU stall is not easy
> to reproduce in short time.
> 
You may want to run the system longer if you can. I suspect the RCU stall
was also side effect of missing interrupts.

Regards,
Santosh
