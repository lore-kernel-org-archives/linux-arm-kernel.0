From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sat, 03 Jul 2010 22:08:29 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <20100702180257.GA8767@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
Message-ID: <4C2F98BD.9020803@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Schwebel wrote:
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
> 
> All measurements have been done on 2.6.34.

The context switch time for PXA270 looks really suspicious. The worst
case context switch time of an AT91RM9200, an armv4 running at 180MHz,
is less than 300us, so, I doubt that the context switch time of a PXA
can be that worse.

-- 
					    Gilles.
