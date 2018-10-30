From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2018 16:10:07 +0100
Subject: [BUG] MVPP2 driver exploding in presence of a tap interface
In-Reply-To: <6bf82e04-5463-aa7d-bbac-f09519ff9815@arm.com>
References: <6355174d-4ab6-595d-17db-311bce607aef@arm.com>
 <20181030105015.GB3407@kwain>
 <7bd72963-1e7c-5175-ba88-fc020d786f0c@arm.com>
 <CAPv3WKfn6QFPnNjpY2dU5-OHftObzdcrHopX8Y9w5h37Zd4BNw@mail.gmail.com>
 <20181030140056.2fc69efc@windsurf>
 <6bf82e04-5463-aa7d-bbac-f09519ff9815@arm.com>
Message-ID: <20181030161007.360d5a53@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 Oct 2018 14:55:01 +0000, Marc Zyngier wrote:

> > I.e, isn't the firmware fix papering over a bug that should be fixed in
> > Linux mvpp2 driver anyway ?  
> 
> Absolutely. Leaving this unpatched in the kernel, with a 100% chance of
> memory corruption is just mad.
> 
> I'm pretty sure there should be a way to sanely reset the interface
> before it starts repainting the memory.

I agree here. Do you still have an image of that old firmware version,
so that we can try to reproduce, and see if we can come up with a way
to reset the BM on boot up that would avoid this issue ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
