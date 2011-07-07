From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 10:05:15 +0200
Subject: [PATCH 1/6 v8] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20110707075954.GF8286@n2100.arm.linux.org.uk>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<201107070954.00419.arnd@arndb.de>
	<20110707075954.GF8286@n2100.arm.linux.org.uk>
Message-ID: <201107071005.15497.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011 09:59:54 Russell King - ARM Linux wrote:
> > Actually, we did discuss this when I first reviewed your patches. FWIW,
> > WM8505, WM8510 and VT8500 don't seem to have PCI, but VT8430 has PCI,
> > according to the data sheet and the patch provided by VIA.
> > 
> > What made this a little hard to understand is the way that VIA provided
> > an emulated PCI bus even on those platforms that didn't have the hardware,
> > apparently because it didn't occur to them to add platform device
> > support to the network driver (via velocity, iirc). They just faked a
> > configuration space for the USB and network devices to make them work
> > with the regular PCI drivers.
> 
> Ok, so it can use the default value I've created for IO_SPACE_LIMIT
> based on whether CONFIG_PCI is enabled or not.
> 

Yes, correct.

	Arnd
