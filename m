From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 20 Apr 2010 10:13:23 +0200
Subject: iMX31 LogicPD LiteKit Kernel 2.6.33.2
In-Reply-To: <z2z3f34cd261004191240nce56a951jb24c4ce3c0c47503@mail.gmail.com>
References: <w2i3f34cd261004141302xdeb23378hfc4d795a6c9811c2@mail.gmail.com>
	<20100415075831.GL30801@buzzloop.caiaq.de>
	<i2i3f34cd261004151408ta09b0ca5lfe8bcd6289fb77ba@mail.gmail.com>
	<20100416083632.GF30801@buzzloop.caiaq.de>
	<z2z3f34cd261004191240nce56a951jb24c4ce3c0c47503@mail.gmail.com>
Message-ID: <20100420081323.GD30807@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 19, 2010 at 01:40:50PM -0600, Badguy Badguy wrote:
> Ok, well I think my problem was simply that I did not have the console
> enabled! Oops!
> and once I seen the LED light go solid, I figured it was locked.
> (must not be being turned off)
> 
> I will mention that the serial port defaults to the 9600 baud implied
> by the driver, this was also giving me trouble.
> I note it attempts to read current state and use it, but must get it
> wrong have not dug deeper yet, simply changed default to what the
> bootloader is using 115200

Yes, you should pass that on the kernel command line.

> I cleaned up my config some more, removed some redundant stuff got it
> to boot to Oops from lack of FS support.
> cannot get to the NFS server, digging into that.

Proably also some config issue? Works well here.

> Can I get a break down on how far you have run this kernel? Do you
> have file system support?

I can fully boot the board via NFS and have a working system with
Ethernet, MMC/SDIO, LED, GPIO, SPI and USB support.

> I notice the NAND driver is throwing bad erase block warnings on a
> large number of blocks, I will change SOM and see if it continues.

I'll again check for NAND and NOR later today, but I'm sure the chips
are at least probed correctly.

Daniel
