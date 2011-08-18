From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Aug 2011 11:15:52 +0200
Subject: [RFC PATCH v2 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04AF6F3062@HQMAIL01.nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<201108171323.38441.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04AF6F3062@HQMAIL01.nvidia.com>
Message-ID: <201108181115.53101.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 August 2011, Stephen Warren wrote:
> It looks like DT already supports the generic case for GPIO; each GPIO
> reference is of the form:
> 
> <&gpio 69 0>
> 
> and so each GPIO has a "parent" specified, and hence can come from a
> different controller.
> 
> For drivers, this is all completely hidden by of_get_gpio().
> 
> I imagine we'd just use the same pattern for pinmux. This would both
> support the general case, and end up being consistent with how GPIOs
> already work, so this seems like a win both ways.
> 

Ah right. I had not seen the gpio binding yet, so that definitely works.

	Arnd
