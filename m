From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Oct 2018 15:22:56 +0000
Subject: [BUG] MVPP2 driver exploding in presence of a tap interface
In-Reply-To: <20181030161007.360d5a53@windsurf>
References: <6355174d-4ab6-595d-17db-311bce607aef@arm.com>
 <20181030105015.GB3407@kwain> <7bd72963-1e7c-5175-ba88-fc020d786f0c@arm.com>
 <CAPv3WKfn6QFPnNjpY2dU5-OHftObzdcrHopX8Y9w5h37Zd4BNw@mail.gmail.com>
 <20181030140056.2fc69efc@windsurf>
 <6bf82e04-5463-aa7d-bbac-f09519ff9815@arm.com>
 <20181030161007.360d5a53@windsurf>
Message-ID: <f016bdf8-9986-962c-dff1-5dcf8b9087ad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/18 15:10, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 30 Oct 2018 14:55:01 +0000, Marc Zyngier wrote:
> 
>>> I.e, isn't the firmware fix papering over a bug that should be fixed in
>>> Linux mvpp2 driver anyway ?  
>>
>> Absolutely. Leaving this unpatched in the kernel, with a 100% chance of
>> memory corruption is just mad.
>>
>> I'm pretty sure there should be a way to sanely reset the interface
>> before it starts repainting the memory.
> 
> I agree here. Do you still have an image of that old firmware version,
> so that we can try to reproduce, and see if we can come up with a way
> to reset the BM on boot up that would avoid this issue ?

Yup. I still have both the original build tree as well as the sdcard, so
you should be able to trigger on demand.

I'll email you the stuff separately, unless you want another delivery
method.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
