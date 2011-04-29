From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 30 Apr 2011 00:16:52 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110429220746.GB14871@n2100.arm.linux.org.uk>
References: <20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110429103723.GF5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291252080.3005@ionos>
	<20110429110610.GJ5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291344020.3005@ionos>
	<20110429132613.GL5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291620170.3005@ionos>
	<20110429220746.GB14871@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1104300009420.3005@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2011 at 05:31:44PM +0200, Thomas Gleixner wrote:
> > }
> 
> I'm going to give up discussing this with you - you have no desire to
> even understand what I'm saying.  I don't see any point continuing this
> discussion any further.

Right, I have no interest in understanding what you want to do. 

At the same time I have yet to see any reasonable answer to basic
questions how the locking and the very basic tree traversal rules are
going to be.

All I got so far is that I'm living in the wrong universe and that I'm
neither able nor willing to understand the reasoning behind your grand
master plan. Pretty constructive.

Thanks,

	tglx
