From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Sep 2014 16:26:36 +0200
Subject: [GIT PULL] ARM: LPC32xx: Device tree updates
In-Reply-To: <54105765.5090708@antcom.de>
References: <540F1409.3070206@antcom.de> <4173517.3fBhGIV2aO@wuerfel>
 <54105765.5090708@antcom.de>
Message-ID: <3900226.tYc6lW0Md4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 September 2014 15:51:33 Roland Stigge wrote:
> 
> > You cleaned up the platform a lot when you took
> > over in 2012, but now we have move other platforms much further
> > and I wonder if you could do some of the same changes.
> > Most importantly, I really want most platforms to be part of
> > ARCH_MULTIPLATFORM and build them into the same image. For
> > lpc32xx, this is currently not possible because you are not using
> > the common clk implementation. Would it be possible for you
> > to look into converting that driver over and moving it to
> > drivers/clk?
> 
> It's certainly possible, but time might be scarce. What would be a good
> reference platform to have a look into as example? Or a hint/link?

I'll let Linus answer that one, he converted a couple of platform and
probably has a better idea than I do.

	Arnd
