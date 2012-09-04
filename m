From: rubini@gnudd.com (Alessandro Rubini)
Date: Tue, 4 Sep 2012 19:35:20 +0200
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the
 Nomadik I2C driver
In-Reply-To: <CACRpkdZESujO=2BU3jeKiX3Cm+JY2UPEXwGkro75FWa5Gio5YQ@mail.gmail.com>
References: <CACRpkdZESujO=2BU3jeKiX3Cm+JY2UPEXwGkro75FWa5Gio5YQ@mail.gmail.com>
 <20120831122323.GC5962@gmail.com>  <5044C82E.5060207@gmail.com>
 <20120903152012.GH31163@gmail.com>  <201209041428.21409.arnd@arndb.de>
Message-ID: <20120904173520.GA18209@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Alessandro Rubini is actively working on bridging this (and
> other amba_device primecells) to PCI, that is the reason why it
> was recently converted to an amba_device.

Yes, I've been inactive for a while but I'm on it right now.

> How is he then supposed to get the proper parameters into the
> driver? Note that the PCI ID is no help at all since the parameters
> depend on what is connected to the I2C bus, not on what it itself is
> connected to. Isn't platform data used in such cases?

I'm using platform data currently, but Davide Ciminaghi is actively
working to convert the configuration to device-tree: the way we pass
platform data to the pci device (and thus amba) is not considered
acceptable by Peter Anvin.

I'm thus asking Davide if he's happy to remove the platform data
configuration path right now (I personally wouldn't be very happy, but
I acknowledge it should happen, sooner or later).

/alessandro
