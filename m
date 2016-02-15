From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Feb 2016 09:17:50 +0100
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160214200755.GB10826@n2100.arm.linux.org.uk>
References: <20160214165010.GA3189@roeck-us.net>
 <20160214195501.GA12289@pengutronix.de>
 <20160214200755.GB10826@n2100.arm.linux.org.uk>
Message-ID: <20160215081750.GD12289@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sun, Feb 14, 2016 at 08:07:55PM +0000, Russell King - ARM Linux wrote:
> On Sun, Feb 14, 2016 at 08:55:01PM +0100, Uwe Kleine-K?nig wrote:
> > So the unexpected abnormality here is that even though this device is
> > instantiated by dt, the driver doesn't provide any compatibles.
> > Either my expectation is wrong, then 67d02a1bbb33455 should be reverted
> 
> Your expectation is wrong.  AMBA primecell devices have hardware IDs
> and are matched to their drivers by those IDs.  Just like PCI.

pci devices don't appear in dt, do they? I don't see the connection
between amba devices and platform devices, see my other mail in this
thread for some more details.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
