From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2016 15:21:45 +0100
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
In-Reply-To: <57B71301.4010005@free-electrons.com>
References: <57b6f38c.23012e0a.374a0.56c6@mx.google.com>
 <20160819141251.5dcc835d@free-electrons.com>
 <20160819130846.GN1041@n2100.armlinux.org.uk>
 <57B71301.4010005@free-electrons.com>
Message-ID: <20160819142145.GQ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 04:09:05PM +0200, Romain Perier wrote:
> I was, wondering, do you boot with a separated DTB or a legacy boot
> (concatenated to the Image) ?
> 
> 
> Could you test with uImage.armada-385-db-ap [1], that's a legacy Image.
> Also, I have uploaded a minimalistic rootfs [2], if you want.
> 
> 1. http://www.free-electrons.com/~romain/pub/cesa/uImage.armada-385-db-ap
> 2. http://www.free-electrons.com/~romain/pub/cesa/rootfs.cpio.xz

I assume you mean Thomas rather than myself, as I have only Clearfog
platforms, which are all Armada 388.

I don't use uImage anymore, except with versions of uboot that are
unable to support zImage booting.  Where zImage booting is supported,
I'm always using a separated DTB.  Doing otherwise is insane IMHO.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
