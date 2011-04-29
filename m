From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 14:26:13 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104291344020.3005@ionos>
References: <1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110429103723.GF5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291252080.3005@ionos>
	<20110429110610.GJ5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291344020.3005@ionos>
Message-ID: <20110429132613.GL5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 02:13:06PM +0200, Thomas Gleixner wrote:
> This are all well defined semantical problems and should be solved in
> common code rather than having different buggy implementations in each
> SoC clock "framework".

Why are you associating functional elements in drivers/clk with the
SoC clock framework?

I think that's the root cause of this misunderstanding, and until you
start realising that these building blocks are not part of the SoC
implementation, we're going to continue arguing about this.
