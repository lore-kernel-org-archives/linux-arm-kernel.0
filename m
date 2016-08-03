From: rogerq@ti.com (Roger Quadros)
Date: Wed, 3 Aug 2016 10:46:24 +0300
Subject: [PATCH 0/3] ARM: omap: fix 4.7 gpmc networking regression
In-Reply-To: <20160802103505.GD28140@atomide.com>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
 <20160802103505.GD28140@atomide.com>
Message-ID: <9cf04231-091c-4ac3-bfb8-8d8be3d591eb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/16 13:35, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [160724 05:11]:
>> Networking is currently broken for Overo boards due to a regression in
>> 4.7. I bisected it down to
>>
>> 	d2d00862dfbb ("memory: omap-gpmc: Support general purpose input
>> 	for WAITPINs")
> ...
> 
>> Note that simply fixing the Overo NAND issue would fix the Overo
>> networking regression, but by restoring the 4.6 gpmc-probe behaviour
>> similar regressions on other OMAP systems are also avoided.
> 
> Roger, got a better fix in mind?
> 

Nope. I'll take patch 1 in my omap-gpmc queue for v4.8.
Thanks for the fixes Johan.

cheers,
-roger
