From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Feb 2010 19:45:28 +0000
Subject: [PATCH 08/13] ARM: LPC32XX: clock tree support
In-Reply-To: <083DF309106F364B939360100EC290F805C8BF7E5A@eu1rdcrdc1wx030.exi.nxp.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-9-git-send-email-wellsk40@gmail.com>
	<20100203163259.GJ11354@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B78796@eu1rdcrdc1wx030.exi.nxp.com>
	<20100203202047.GC20113@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8BF7E5A@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100205194528.GA31511@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2010 at 05:48:36PM +0100, Kevin Wells wrote:
> This approach always returned a non-0 clock rate for the clock, regardless
> of whether the clock was enabled or not. Does the clk_get_rate() function
> need to return a rate of 0 if the clock is disabled?

No - there's no requirement for that to be the case.
