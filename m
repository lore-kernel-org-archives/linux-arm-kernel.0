From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 22 May 2012 08:42:43 -0400
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <201205220733.38308.arnd@arndb.de>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
 <20120521173506.GH12741@lunn.ch>
 <20120521181156.GU24238@titan.lakedaemon.net>
 <201205220733.38308.arnd@arndb.de>
Message-ID: <20120522124243.GW24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 07:33:37AM +0000, Arnd Bergmann wrote:
> On Monday 21 May 2012, Jason Cooper wrote:
> > On Mon, May 21, 2012 at 07:35:06PM +0200, Andrew Lunn wrote:
> > > > > > board/<boardname>
> > > > > > 
> > > > > 
> > > > > Do you mean old style, none DT, boards?
> > > > 
> > > > No, new DT boards.
> > > 
> > > O.K. Then a better name would be dt-board/<boardname>
> > 
> > Well, no new boards are being accepted without DT support.  However, I
> > have no strong opinion on the matter, so dt-board/ it is, then.
> 
> Just one branch should be enough for all the boards, I think. As soon
> as you have the gpio bindings taken care of, the board specific parts
> will shrink significantly anyway.

Ok, sounds good.

thx,

Jason.
