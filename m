From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 15 Feb 2012 14:09:56 +0100
Subject: [PATCH v3 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
In-Reply-To: <4F3ABA77.8010303@gmail.com>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
 <1329242172-4214-3-git-send-email-b-cousson@ti.com>
 <4F3ABA77.8010303@gmail.com>
Message-ID: <4F3BAEA4.6060901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/14/2012 8:48 PM, Rob Herring wrote:
> On 02/14/2012 11:56 AM, Benoit Cousson wrote:
>> Add a function to initialize the OMAP2/3 interrupt controller (INTC)
>> using a device tree node.
>>
>> This version take advantage of the new irq_domain_add_legacy API.
>>
>> Replace some printk() with the proper pr_ macro.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>
> Given that you plan to do gen irqchip:

Yes, I will. I even already have to patch, but I'm just trying to 
minimize the dependency since I'd like that to be merged for 3.4.
That series already missed 3.3.

> Acked-by: Rob Herring<rob.herring@calxeda.com>

Thanks,
Benoit
