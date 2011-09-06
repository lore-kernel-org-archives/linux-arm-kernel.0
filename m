From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Sep 2011 21:45:25 +0200
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <20110906110726.GN6619@n2100.arm.linux.org.uk>
References: <20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211522280.20358@xanadu.home>
	<20110906092816.GC3548@atomide.com>
	<20110906093738.GJ6619@n2100.arm.linux.org.uk>
	<20110906102703.GA1895@atomide.com>
	<20110906105206.GL6619@n2100.arm.linux.org.uk>
	<20110906110143.GB1895@atomide.com>
	<20110906110726.GN6619@n2100.arm.linux.org.uk>
Message-ID: <20110906194525.GP28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 12:07:26PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 06, 2011 at 04:01:43AM -0700, Tony Lindgren wrote:
> > Yes I agree. As an alternative, how about we drop all the debug_ll code
> > and allow people to patch it in as needed?
> 
> Given all this argument over it, I'm mindful to rip out all the debug_ll
> code and keep it permanently as an offline patch to prevent further abuse.
Can you please just nack the changes and keep DEBUG_LL as is? You'll
have my and IIRC Sascha's support for it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
