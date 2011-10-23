From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Oct 2011 10:20:59 +0100
Subject: [RFC][PATCH] uncompress.h cleanup and DT support
In-Reply-To: <CAGVye5NQa857oNPEgQBWE0twQHL6U3BTeSOaR2aTiJzUxMvFSg@mail.gmail.com>
References: <CAGVye5MSqdxh0DzCMt79sKk+Z0Trfro0RNDr-4zccMh7O7vGiA@mail.gmail.com>
	<20111023084132.GA12814@n2100.arm.linux.org.uk>
	<CAGVye5NQa857oNPEgQBWE0twQHL6U3BTeSOaR2aTiJzUxMvFSg@mail.gmail.com>
Message-ID: <20111023092059.GB12814@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 11:12:50AM +0200, Zoltan Devai wrote:
> 2011/10/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Sun, Oct 23, 2011 at 10:18:29AM +0200, Zoltan Devai wrote:
> >> Plase consider all this as RFC, it's mostly not even compile-tested.
> >> If you think it's worth to follow-up, I'm happy to do it.
> >
> > Is the patch available?
> git://github.com/zdevai/linux.git uncompress-h

I'd rather not pull your tree just to look at the patch.  Is it
available somewhere else?

> > Has this been tested with ZBOOT_ROM?
> Not yet, but I don't see a reason why this would break it.

Please try building it with ZBOOT_ROM enabled.
