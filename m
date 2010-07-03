From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 03 Jul 2010 01:44:07 -0400 (EDT)
Subject: Some benchmarks on ARM
In-Reply-To: <20100702180257.GA8767@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1007030136510.32016@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Jul 2010, Robert Schwebel wrote:

> Hi,
> 
> We have recently made some benchmarks, in order to get a little bit
> better fealing about where ARM cpus are today, especially when it comes
> to the "recent" ones, and in comparism to the Atom. So we collected a
> few benchmarks (most from lmbench) and did some actual measurements.
> 
> Here is a little article:
> http://www.pengutronix.de/development/kernel/arm-benchmarks-20100702_en.html
> 
> I'm pretty sure that there are quite a few things where people on ALKML
> have good ideas where the effects come from or how to improve the
> methodology - so I'd be glad to get some feedback from the community!

It would be nice if you could add measurements for recent Marvell 
products there, such as the Kirkwood (think SheevaPlug or the like 
running at 1.2 GHz), or Dove.  I wold expect memory throughput on those 
to be quite good.

Also, your article is completely missing on the other metric which is 
power consumption.  After all what would be most interesting is not the 
various performance numbers per MHz but those performance numbers per 
Watt.


Nicolas
