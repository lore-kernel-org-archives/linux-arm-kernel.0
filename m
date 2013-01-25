From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jan 2013 07:52:14 -0500
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <201301251115.47480.arnd@arndb.de>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
Message-ID: <20130125125214.GI1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 11:15:47AM +0000, Arnd Bergmann wrote:
> On Friday 25 January 2013, Jason Cooper wrote:
> > This is a second cut at cleaning up mach-kirkwood/.  There are a few DT
> > conversions (topkick -> mvsdio, pinctrl) which, once reviewed, I'll put in the
> > normal pull request cycle.
> > 
> > The others which remove board-*.c files, I'll keep updating against
> > mvebu/for-next, and then apply at the end of the merge window.
> > 
> > Please test as you are able.
> 
> Great work, it's really nice to see where things are going now!
> 
> In patch 7, the changeset text seems to be indented wrong, but the
> patch is still good.
> 
> I wonder if it makes sense to collapse the few remaining DT based
> board files now and move their entire contents back into board-dt.c.
> Of course, if you think they will all be gone soon anyway, there
> is no point.

Once I have the mv643xx_eth binding working reliably, preferably with
mvmdio, I'll take a look at removing the last board-*.c files.  If the
stars align, we'll get it all done for v3.9.

The only big thing left will be pcie.

thx,

Jason.
