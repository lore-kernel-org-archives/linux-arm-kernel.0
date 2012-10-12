From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Oct 2012 10:12:52 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <201210120803.54539.arnd@arndb.de>
References: <20121007015300.828366635@gmail.com>
 <20121012070651.GA17511@glitch> <20121012092617.37e82610@skate>
 <201210120803.54539.arnd@arndb.de>
Message-ID: <20121012101252.6c3b7dce@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Fri, 12 Oct 2012 08:03:54 +0000, Arnd Bergmann wrote:

> I would certainly like to see this, yes. I had a patch for it ages
> ago, but would start over again if I did this now.
> 
> I don't have time to do the conversion at the moment, but I would
> certainly welcome a patch that does it. I can give some details about
> the problems with that and how I think they should be solved.

I did start working on such a patch a few weeks ago, but converting all
the platforms to use IOMEM() was really boring. But now you did that, I
can try to revive my patch, see if it works, and post it if you're
interested.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
