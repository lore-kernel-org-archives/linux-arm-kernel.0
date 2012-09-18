From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 16:04:49 +0000
Subject: [PATCH 01/24] ARM: shmobile: use __iomem pointers for MMIO
In-Reply-To: <20120918115038.GB3198@verge.net.au>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <201209180831.06572.arnd@arndb.de> <20120918115038.GB3198@verge.net.au>
Message-ID: <201209181604.49562.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Simon Horman wrote:
> > I agree it's not nice to have to do this, but this is largely because
> > of shmobile doing things differently from all other ARM platforms, on
> > which the respective patches tend to clean up things and reduce the
> > number of type casts.
> > 
> > The only alternative I can see is for shmobile to introduce its own
> > mach/io.h file with the relaxed type checking, but that would only
> > defer the problem until the point where you want shmobile to be part
> > of the common multiplatform kernel binary.
> 
> If it is needed in the long term, then I'm happy with it going in now.
> Could you remove the portion that Paul objected to?

Yes, I already did that.

	Arnd
