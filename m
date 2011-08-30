From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 30 Aug 2011 09:01:37 -0700
Subject: [PATCH 1/2] sdhci/tegra: Add Device Tree probing support
In-Reply-To: <20110830034035.GC19294@S2100-06.ap.freescale.net>
References: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
	<20110830034035.GC19294@S2100-06.ap.freescale.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B3279D3F@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote at Monday, August 29, 2011 9:41 PM:
> On Tue, Aug 23, 2011 at 12:15:33PM -0600, Stephen Warren wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Add hooks to read gpio configuration out of the device tree node.
...
> > diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
...
> > +* NVIDIA Tegra Secure Digital Host Controller
> > +
> > +This controller on Tegra family SoCs provides an interface for MMC, SD,
> > +and SDIO types of memory cards.
> > +
> > +Required properties:
> > +- compatible : Should be "nvidia,<chip>-sdhci"
> > +- reg : Should contain eSDHC registers location and length
> > +- interrupts : Should contain eSDHC interrupt
> 
> You may want to replace eSDHC with something Tegra specific.

True. The patch is already submitted. Do you think it's worth posting one
just to fix that; it still seems pretty clear what's required?

Thanks.

-- 
nvpublic
