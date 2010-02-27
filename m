From: mkl0301@gmail.com (Lin Mac)
Date: Sat, 27 Feb 2010 15:32:29 +0800
Subject: SMP performance question(Re: USB mass storage and ARM cache
	coherency)
Message-ID: <10d816431002262332ke92737cvafcbff63fbbb6c85@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

(I have changed my mail addr from mkl0301 at hotmail.com to mkl0301 at gmail.com)

> My latest solution - http://bit.ly/apJv3O - is to use dummy
> read-for-ownership or write-for-ownership accesses in the DMA cache
> flushing functions to force cache line migration from the other CPUs.
> Our current benchmarks only show around 10% disc throughput penalty
> compared to the normal SMP case (compared to the UP case the penalty is
> bigger but that's due to other things).

So it sounds like the performance of UP > __Normal SMP__ > RFO/WFO + SMP.

Maybe I've got the wrong expection, for I'm not experienced in SMP.
But I do expect the performance of  __Normal SMP__ should at least >=
UP's.

Why the performance of UP would > __Normal SMP__?
And what's the __Normal SMP__ definition?

Best Regard,
Mac Lin
