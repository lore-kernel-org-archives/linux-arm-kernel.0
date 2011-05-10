From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 May 2011 23:42:33 +0100
Subject: [RFC 1/2] ARM: Tegra: Device Tree Support: Update how sdhci
	devices are initialized
In-Reply-To: <4DC9BD39.30108@secretlab.ca>
References: <20110510201108.22693.50319.stgit@riker>
	<20110510201414.22693.7427.stgit@riker>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA06A@HQMAIL01.nvidia.com>
	<BANLkTingm7PCJPC-xCremYg_Ab7qFvPSag@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA077@HQMAIL01.nvidia.com>
	<4DC9BD39.30108@secretlab.ca>
Message-ID: <20110510224233.GB19154@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 03:33:29PM -0700, John Bonesio wrote:

> A following patch, which I'll send later this week/early next week, will
> instantiate the wm8903 audio codec device solely from the device tree.

Please CC me on this work - I've got an interest both from the chip and
subsystem point of view in how this stuff ends up looking and there's
some fun and games with audio in device tree.
