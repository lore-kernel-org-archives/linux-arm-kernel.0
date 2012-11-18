From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 18 Nov 2012 11:57:40 +0100
Subject: Final call for 3.8 arm-soc patches
In-Reply-To: <201211162111.34615.arnd@arndb.de>
References: <201211162111.34615.arnd@arndb.de>
Message-ID: <20121118115740.17857b53@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Fri, 16 Nov 2012 21:11:34 +0000, Arnd Bergmann wrote:

> We are currently at linux-3.7-rc5, which means the merge window is coming
> closer. We already have 759 changesets in arm-soc and I know of a few ones
> coming (tegra, clps711x, bcm), but I don't know what the status for some
> of the bigger ones (exynos/s5p/s3c, mvebu/orion, pxa/mmp). If you have
> more patches coming, please send all remaining pull requests soon, or
> let us know what is holding you up. I hope this way we can avoid having
> to reject pull requests that come too late in the cycle.

We still have quite a lot of things to send from the Marvell side, at
least:

 * A new network driver for Armada 370/XP, which has been ACKed by
   David Miller

 * Clock framework support for Kirkwood, Dove, Armada 370 and Armada XP.

 * Support for the Globalscale Mirabox and PlatHome OpenBlocks
   platforms.

 * Rework of the XOR Marvell driver and addition of a Device Tree
   binding to it.

 * Conversion of Kirkwood boards to the pinctrl framework.

 * Conversion of Kirkwood boards to the usage of regulators.

 * L2 cache support for Armada 370/XP.

Even though quite a bit of this code as been around for some time,
Jason Cooper hasn't had the time until now to send the pull requests. I
hope Jason will manage to do the corresponding pull requests soon, or
I'll have to do them myself because we really don't want to miss the
3.8 merge window for those changes. I'll try to see with Jason either
later today or tomorrow what are his plans.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
