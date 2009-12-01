From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 01 Dec 2009 12:48:42 -0500 (EST)
Subject: Git pull request: Orion/Kirkwood/Dove stuff for next merge window
In-Reply-To: <20091201095654.GA29135@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.0911262005410.2059@xanadu.home>
	<alpine.LFD.2.00.0911301122270.5820@xanadu.home>
	<20091130163011.GD7028@n2100.arm.linux.org.uk>
	<20091201095654.GA29135@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0912011245430.5820@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Dec 2009, Russell King - ARM Linux wrote:

> On Mon, Nov 30, 2009 at 04:30:11PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 30, 2009 at 11:23:49AM -0500, Nicolas Pitre wrote:
> > > Ping.
> > 
> > Not pulling just yet.
> 
> I'm sorry, I can't pull with this dove db crap in.  The machine database
> is in a mess with respect to it - there's at least two dove_db machine IDs
> registered.
> 
> Saeed needs to talk to me to get it sorted _first_ before submitting it
> for mainline.  Please drop it from your tree.

Given that the second dove_db should be renamed to dove_db2 according to 
Saeed (and I think you made the change already) then are you OK to pull 
it as is now?


Nicolas
