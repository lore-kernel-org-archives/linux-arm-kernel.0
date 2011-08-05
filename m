From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 5 Aug 2011 09:29:21 +0100
Subject: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
In-Reply-To: <20110805080620.GE28651@trinity.fluff.org>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<1312498820-2275-2-git-send-email-swarren@nvidia.com>
	<20110805000148.GB13321@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049F171EC1@HQMAIL01.nvidia.com>
	<20110805053510.GA16956@opensource.wolfsonmicro.com>
	<20110805080620.GE28651@trinity.fluff.org>
Message-ID: <20110805082921.GA4977@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 09:06:20AM +0100, Ben Dooks wrote:

> I would say that setting the interrupt should deal with all the necessary
> configuration to get that interrupt working. In the case of pretty much all
> of the SoCs I have been involved with have always set the GPIO's function
> to allow the interrupt to pass through.

That's what Stephen is trying to do, essentially.  It's looking like
it's more sensible to fix it in the Tegra interrupt drivers, though.
