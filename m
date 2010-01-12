From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 12 Jan 2010 00:15:26 +0000
Subject: [PATCH 1/3] ARM: SAMSUNG: Add config option for number of
	additional GPIO pins.
In-Reply-To: <20100111124927.GB27161@rakim.wolfsonmicro.main>
References: <1263203046-29219-1-git-send-email-kgene.kim@samsung.com>
	<20100111103338.GA3440@sirena.org.uk>
	<20100111122715.GG1224@trinity.fluff.org>
	<20100111124927.GB27161@rakim.wolfsonmicro.main>
Message-ID: <20100112001526.GH1224@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 12:49:27PM +0000, Mark Brown wrote:
> On Mon, Jan 11, 2010 at 12:27:15PM +0000, Ben Dooks wrote:
> 
> > Having this as a user settable field might be useful if plugging on
> > GPIO expanders at runtime.
> 
> If that gets to be anything other than an extremely niche use case the
> GPIO allocation would need to have a dynamic limit anyway, though.

Yes, however a kconfig case where you can set the minimum value of an
integer would make the whole extra-gpio configuration much cleaner and
avoid having toadd further configuration symbols when someone wants an
extra 256 or whatever GPIOS.

Having a dynamic GPIO range would also be nice, someone should look at
adding it to the GPIO code.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
