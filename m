From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Feb 2012 00:10:56 +0000
Subject: [GIT PULL] cs89x0 platform support
In-Reply-To: <20120209074040.GS3852@pengutronix.de>
References: <20120201134415.GU1990@pengutronix.de>
 <CAOesGMiRTZZ9Gn9boEwyHbmG3H=jSqEHB7CDqf8Vr05LXTcx+w@mail.gmail.com>
 <20120209074040.GS3852@pengutronix.de>
Message-ID: <201202100010.56842.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 February 2012, Sascha Hauer wrote:
> > Arnd had some outstanding comments on the ethernet driver, so I will
> > hold off pulling until that is resolved.
> 
> I think what Arnd made is some suggestions to further clean up the
> driver, I don't think that the current patches should depend on doing
> more work. This series is a nice cleanup and a solution for a five year
> old problem. For the first time we can enable the cs89x0 driver in the
> defconfig and thus make ethernet work on some boards.

Ok, fair enough. Let's apply your series for now then. If I get to
make my io.h cleanup before you or someone else does the changes
necessary to convert the driver to not use inb/outb, it will be broken
again though.

	Arnd
