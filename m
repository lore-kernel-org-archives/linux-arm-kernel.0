From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 May 2013 20:25:10 +0100
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
Message-ID: <20130516192510.GV18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What follows is my DRM driver for Dove, which I've been working on with
the Solid-run Cubox, which only offers HDMI output via the TDA19988
chip.

Not everything is finished off perfectly in this driver; there's quite
a number of ragged edges (particularly with page flipping, which is
completely untested.)

I have most of the Xorg driver complete - none of the DRI interfaces
checked yet (partly because that involves quite an amount of work with
Mesa).

However, graphics, video overlay, interlacing, accelerated GPU via the
original vivante support all works through this driver, with this driver
providing the X pixmaps.
