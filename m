From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 12 Feb 2014 10:52:08 -0500
Subject: [PATCH 2/3] ARM: mvebu: use GPIO DT defines in Armada 370/XP
 boards
In-Reply-To: <20140212102448.06d8cc56@skate>
References: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392138433-12573-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140212074946.GC30814@lunn.ch> <20140212102448.06d8cc56@skate>
Message-ID: <20140212155208.GL27395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 10:24:48AM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Wed, 12 Feb 2014 08:49:46 +0100, Andrew Lunn wrote:
> 
> > What i did for kirkwood is include both gpio.h and input.h in
> > kirkwood.dtsi. Quite a few other systems do that, rather than each
> > .dts file having to include them. However i don't have a strong
> > opinion.
> 
> Right, I don't have a strong opinion on this either. I did it this way
> because a few other .dts files for Armada boards (Netgear NAS) were
> already including these header files.
> 
> I guess it is clearly something that can be factorized later on as the
> number of Armada boards needing this grows.

Same here, it's cleaner, but it can wait for cleanups next window.

thx,

Jason.
