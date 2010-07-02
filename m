From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Fri, 02 Jul 2010 22:34:33 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <20100702180257.GA8767@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
Message-ID: <4C2E4D59.8030300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 2010-07-02 20:02, Robert Schwebel wrote:
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


It would be nice if you could add the exact command lines you used for the different tests so it's easy to run the same tests on other boards as well. I suppose you added some flag to gcc to make use of the floating point hardware in i.MX35?

Could also add information on the RAM characteristics of each board? DDR1/DDR2, 16 bit/32 bit wide, and speed (MHz9.

 

Regards, Magnus Lilja
