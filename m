From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 05 Jul 2010 16:31:27 +0300
Subject: Some benchmarks on ARM
In-Reply-To: <20100705132339.GY20855@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>	<alpine.LFD.2.00.1007030136510.32016@xanadu.home>	<4C31D861.607@gmail.com>
	<20100705132339.GY20855@pengutronix.de>
Message-ID: <4C31DEAF.6020205@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Schwebel wrote:
> Maurus,
> 
> On Mon, Jul 05, 2010 at 03:04:33PM +0200, Maurus Cuelenaere wrote:
>> Some quick tests of lmbench on a Sheevaplug:
> 
> Thanks a lot - we'll update the document soon, wiht the exact command
> lines included.
> 
>> I'm not sure if I'm doing this right, but it looks like the Sheevaplug
>> beats all ARM chips (except on FP) on the tests done at [1]. Looks
>> like these tests heavily depend on the clock frequency.
> 
> If anyone has an idea for better benchmarks, I'd be very interested. We
> have been searching for benchmarks which:
> 
> - can be easily cross compiled to all involved platforms
> - show the different aspects of the systems

Native kernel build? ;-)

> rsc


-- 
Sincerely yours,
Mike.
