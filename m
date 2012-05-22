From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 May 2012 07:33:37 +0000
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <20120521181156.GU24238@titan.lakedaemon.net>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
 <20120521173506.GH12741@lunn.ch>
 <20120521181156.GU24238@titan.lakedaemon.net>
Message-ID: <201205220733.38308.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 May 2012, Jason Cooper wrote:
> On Mon, May 21, 2012 at 07:35:06PM +0200, Andrew Lunn wrote:
> > > > > board/<boardname>
> > > > > 
> > > > 
> > > > Do you mean old style, none DT, boards?
> > > 
> > > No, new DT boards.
> > 
> > O.K. Then a better name would be dt-board/<boardname>
> 
> Well, no new boards are being accepted without DT support.  However, I
> have no strong opinion on the matter, so dt-board/ it is, then.

Just one branch should be enough for all the boards, I think. As soon
as you have the gpio bindings taken care of, the board specific parts
will shrink significantly anyway.

	Arnd
