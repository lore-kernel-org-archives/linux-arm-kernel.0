From: alex.shi@linaro.org (Alex Shi)
Date: Fri, 16 May 2014 15:41:57 +0800
Subject: RCU stall on panda
In-Reply-To: <5375091D.3010607@ti.com>
References: <53675C5F.10509@linaro.org>
 <20140505180617.GM8754@linux.vnet.ibm.com>
 <20140512212102.GF5668@atomide.com> <5371BD69.8010600@linaro.org>
 <20140513153220.GC16837@atomide.com> <53747E6D.60500@linaro.org>
 <53748371.5030704@linaro.org> <5374C07C.1070400@linaro.org>
 <20140515183247.GF23659@atomide.com> <5375091D.3010607@ti.com>
Message-ID: <5375C145.6070904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2014 02:36 AM, Santosh Shilimkar wrote:
>>> >> yes.
>>> >> My board is panda ES. without this revert, it works.
>> > 
>> > Care to specify what linux version you are testing against?
>> > 
>> > Does it hang in idle always immediately on booting?
>> > 
>> > Or does the serial console first hang with sysrq still
>> > working (ctrl-a h in minicom for help) with device
>> > eventually locking up hard?
>> >
> I just posted an updated patch Alex on other thread.
> Attaching here again for your reference. Please try
> it out and see if the you still get a hang.

it does not hang this time.

but I am not sure it can solve my problem, since RCU stall is not easy
to reproduce in short time.

-- 
Thanks
    Alex
