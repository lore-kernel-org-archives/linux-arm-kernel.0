From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Aug 2012 17:15:03 -0400
Subject: arm: move plat-orion platform_data headers to the right place
In-Reply-To: <20120828202534.GK19437@titan.lakedaemon.net>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120828201134.GM9886@lunn.ch>
 <20120828202534.GK19437@titan.lakedaemon.net>
Message-ID: <20120828211503.GM19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 04:25:34PM -0400, Jason Cooper wrote:
> On Tue, Aug 28, 2012 at 10:11:34PM +0200, Andrew Lunn wrote:
> > > This series has been built tested for orion5x_defconfig,
> > > dove_defconfig, kirkwood_defconfig and mv78x00_defconfig.
> > 
> > It would be nice if you could also build test the affected powerpc
> > platforms.
> 
> If my toolchain builds, I'll test it.

Ok, built the following defconfigs with a generic powerpc toolchain:

c2k_defconfig
chrp32_defconfig
prpmc2800_defconfig

This exercises I2C_MV64XXX and MV643XX_ETH.  The others don't appear to
be used in powerpc.  But I don't use powerpc so take it for what it's
worth.

thx,

Jason.
