From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 30 Jul 2011 18:42:43 -0600
Subject: [PATCH] net/smsc911x: add device tree probe support
In-Reply-To: <20110729171314.GC2241@S2100-06.ap.freescale.net>
References: <20110725213723.GI26735@ponder.secretlab.ca>
	<20110726010154.GG21641@S2100-06.ap.freescale.net>
	<alpine.LFD.2.00.1107252105561.12766@xanadu.home>
	<20110726013026.GH21641@S2100-06.ap.freescale.net>
	<alpine.LFD.2.00.1107252222540.12766@xanadu.home>
	<20110729023626.GB1946@S2100-06.ap.freescale.net>
	<20110729154723.GC11164@ponder.secretlab.ca>
	<20110729160343.GA2241@S2100-06.ap.freescale.net>
	<20110729162629.GI11164@ponder.secretlab.ca>
	<20110729171314.GC2241@S2100-06.ap.freescale.net>
Message-ID: <20110731004243.GB21433@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2011 at 01:13:15AM +0800, Shawn Guo wrote:
> On Fri, Jul 29, 2011 at 10:26:29AM -0600, Grant Likely wrote:
> > On Sat, Jul 30, 2011 at 12:03:44AM +0800, Shawn Guo wrote:
> > > On Fri, Jul 29, 2011 at 09:47:23AM -0600, Grant Likely wrote:
> > > > On Fri, Jul 29, 2011 at 10:36:26AM +0800, Shawn Guo wrote:
> > > > > Since I do not get any suggestion here, I'm going to follow the driver
> > > > > name to use '911' as the model number.  Please tell me if there is any
> > > > > better one.
> > > > 
> > > > What is the manufacturer part name?  lan9111 or lan91c11?  The
> > > > manufacturer's documented part number is almost always preferred.
> > > > 
> > > I just posted the v2 of the patch, and chose to use 'smsc,lan9115'
> > > which is the first model supported in the driver.  This is the same
> > > approach I used with i.mx device bindings.
> > 
> > You haven't answered the question.
> > 
> For 9115 example, the part number in data sheet is "LAN9115".

Okay, good.  Thanks.

g.
