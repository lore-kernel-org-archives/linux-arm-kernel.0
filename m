From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 19:33:12 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <alpine.LFD.2.00.1108211425400.20358@xanadu.home>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
	<20110819110940.GC8918@e102144-lin.cambridge.arm.com>
	<20110819113937.GS31404@pengutronix.de>
	<20110821091851.GI12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211355580.20358@xanadu.home>
	<20110821181728.GH28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211425400.20358@xanadu.home>
Message-ID: <20110821183312.GJ28546@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 02:28:46PM -0400, Nicolas Pitre wrote:
> On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:
> > Tough.  That's the way it is and it has to be lived with.  Early board
> > bring up has absolutely nothing to do with users.  If users are doing
> > early board bringup, they are kernel developers by definition.
> 
> So be it if you insist.  We'll then have to invent a better 
> infrastructure in parallel to be able to do early enough serial output 
> for users, both for earlyprintk and the zImage decompressor.

"Users" have nothing to do with it.

In any case, that will probably be _much_ better because it can be
independent of the debugging code to be used for sort out the *assembly*
part of the kernel boot.
