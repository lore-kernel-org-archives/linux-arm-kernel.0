From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Jul 2013 18:50:07 +0200
Subject: [PATCH] arm: choose debug/uncompress.h include when uncompress
 debug is disabledo
In-Reply-To: <alpine.DEB.2.02.1307181755371.8258@kaball.uk.xensource.com>
References: <1373897706-15331-1-git-send-email-julien.grall@linaro.org>
 <20130718165007.GA24642@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1307181755371.8258@kaball.uk.xensource.com>
Message-ID: <201307201850.07406.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 July 2013, Stefano Stabellini wrote:
> > Lastly, aren't all ARMv7 kernels (therefore Xen supporting kernels)
> > supposed to be part of the multiplatform kernel stuff now?
> 
> Most of them, yes. However some of them, like exynos5250, are not yet.

It's just a matter of time. I had a patch for 3.10 to enable multiplatform
on exynos, but it missed both the 3.10 and 3.11 merge windows by a small
margin (for different reasons). We definitely want all ARMv7 platforms
to be multiplatform in the not too distant future.

	Arnd
