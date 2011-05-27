From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 27 May 2011 21:00:16 +0530
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <1306510165.27474.272.camel@e102391-lin.cambridge.arm.com>
References: <1306343335.21578.65.camel@twins>	
	<1306358128.21578.107.camel@twins>	
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>	
	<1306405979.1200.63.camel@twins>	
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>	
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>	
	<20110526154508.GA13788@redhat.com>
	<1306425584.2497.81.camel@laptop>	
	<1306426148.2497.83.camel@laptop>
	<20110526170422.GA18413@redhat.com>	
	<1306430264.2497.88.camel@laptop>
	<1306430633.2497.91.camel@laptop>	 <4DDFC1D6.4010303@ti.com>
	<1306510165.27474.272.camel@e102391-lin.cambridge.arm.com>
Message-ID: <4DDFC388.1050506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/27/2011 8:59 PM, Marc Zyngier wrote:
> On Fri, 2011-05-27 at 20:53 +0530, Santosh Shilimkar wrote:
[..]

>> Are you planning send version of this patch for stable .39
>> too ?
>
> .39 is fine, as the ttwu() changes only appeared in mainline during the
> current merge window.
>
Thanks Marc for info.

Regards
Santosh
