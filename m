From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Nov 2014 22:32:43 +0100
Subject: mvebu: tclk detection for armada-xp and marvell packet processor
 with integrated CPU
In-Reply-To: <546A5832.6020008@alliedtelesis.co.nz>
References: <546959A3.9040206@alliedtelesis.co.nz>
 <20141117093437.0ca5a3ef@free-electrons.com>
 <20141117141839.GM2001@lunn.ch>
 <546A5832.6020008@alliedtelesis.co.nz>
Message-ID: <20141117213243.GA4080@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > kirkwood-98dx4122.dtsi
> 
> Off topic but, cool bobcat1 support (err, I mean I recognize that 
> official part number).

It is very minimal support. I wish there was more, and i would love to
play with this chip, or the one you have, but the datasheets is not
available.
 
> We have existing products using this and others with a proper kirkwood. 
> Unfortunately they all have fdt unaware bootloaders.

You can use appended dt. Put the blob on the end of the kernel, and
with the right options turn on, it will find it. Also, keymile, how
did most of the 98dx4122 work contributed to uboot. So you can
probably use a mainline uboot.

	 Andrew
