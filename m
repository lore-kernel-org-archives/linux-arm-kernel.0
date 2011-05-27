From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 27 May 2011 15:41:49 -0400 (EDT)
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()" locks
	up on ARM
In-Reply-To: <20110527120629.GA32617@elte.hu>
References: <1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
	<20110526125007.GA27083@elte.hu>
	<BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
	<20110527120629.GA32617@elte.hu>
Message-ID: <alpine.LFD.2.00.1105271532060.3207@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 May 2011, Ingo Molnar wrote:

> I'd suggest doing this once modern ARM chips get so widespread that 
> you can realistically induce a ~700 usecs irqs-off delays on old, 
> virtual-cache ARM chips. Old chips would likely use old kernels 
> anyway, right?

Those "old" ARM chips are still largely produced and fitted in new 
designs, and using latest kernels.  They are unlikely to fade away 
before a couple years.


Nicolas
