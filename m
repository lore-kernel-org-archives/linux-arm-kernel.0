From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jul 2011 20:49:16 +0100
Subject: [PATCH] arm/dt: tegra devicetree support
In-Reply-To: <20110720184758.GG4642@ponder.secretlab.ca>
References: <20110719234158.2779.15394.stgit@ponder>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDEE27@HQMAIL01.nvidia.com>
	<20110720160355.GB2406@sirena.org.uk>
	<20110720183133.GE4642@ponder.secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDEF01@HQMAIL01.nvidia.com>
	<20110720184758.GG4642@ponder.secretlab.ca>
Message-ID: <20110720194915.GA26043@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 12:47:58PM -0600, Grant Likely wrote:

> Sure, the tegra-wm8903 property can be dropped.  If we start to see a
> really well established pattern of the tegra paired with a wm8903,
> then at that point we can define a compatible property for it and
> document exactly what it means (document the boundaries and
> assumptions that the compatible value requires).

There is actually such a pattern, for various reasons a huge proportion
of Tegra systems are straight clones of the reference designs and the
reference designs mostly used WM8903.
