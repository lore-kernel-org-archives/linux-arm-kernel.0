From: horms@verge.net.au (Simon Horman)
Date: Wed, 19 Sep 2012 08:56:21 +0900
Subject: [PATCH 01/24] ARM: shmobile: use __iomem pointers for MMIO
In-Reply-To: <201209181604.49562.arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <201209180831.06572.arnd@arndb.de>
 <20120918115038.GB3198@verge.net.au>
 <201209181604.49562.arnd@arndb.de>
Message-ID: <20120918235619.GA12583@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 04:04:49PM +0000, Arnd Bergmann wrote:
> On Tuesday 18 September 2012, Simon Horman wrote:
> > > I agree it's not nice to have to do this, but this is largely because
> > > of shmobile doing things differently from all other ARM platforms, on
> > > which the respective patches tend to clean up things and reduce the
> > > number of type casts.
> > > 
> > > The only alternative I can see is for shmobile to introduce its own
> > > mach/io.h file with the relaxed type checking, but that would only
> > > defer the problem until the point where you want shmobile to be part
> > > of the common multiplatform kernel binary.
> > 
> > If it is needed in the long term, then I'm happy with it going in now.
> > Could you remove the portion that Paul objected to?
> 
> Yes, I already did that.

Great, thanks.
