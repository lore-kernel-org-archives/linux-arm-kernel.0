From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Jul 2011 09:25:57 -0400 (EDT)
Subject: [PATCH] ARM: mach-s3c24a0: delete
In-Reply-To: <201107061251.34669.arnd@arndb.de>
References: <alpine.LFD.2.00.1106281613380.2142@xanadu.home>
	<alpine.LFD.2.00.1107051357480.14596@xanadu.home>
	<alpine.LFD.2.00.1107051721080.14596@xanadu.home>
	<201107061251.34669.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1107060924260.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Arnd Bergmann wrote:

> On Wednesday 06 July 2011, Nicolas Pitre wrote:
> > > 
> > > commit 896ce6bc5bf1e0f963186ab0db4e692ecebeb14c
> > > Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > Date:   Tue Jul 5 13:55:21 2011 -0400
> > > 
> > >     ARM: mach-s3c2400: delete
> > 
> > And here's some more I'm folding into that patch:
> 
> Ah, good. I was about to comment about the serial driver.
> 
> For the whole patch
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

I also removed the s3c24a0 serial driver too, and folded it into the 
corresponding patch.


Nicolas
