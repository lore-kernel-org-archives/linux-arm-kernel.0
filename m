From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 13 Jan 2015 19:42:55 +0800
Subject: [PATCH v2] net: fec: fix MDIO bus assignement for dual fec SoC's
In-Reply-To: <c9a7077c1f800f5a56ef53cd721e73f6@agner.ch>
References: <1420812103-5865-1-git-send-email-stefan@agner.ch>
 <BLUPR03MB373862B10A8C60BCB113B70F5430@BLUPR03MB373.namprd03.prod.outlook.com>
 <c9a7077c1f800f5a56ef53cd721e73f6@agner.ch>
Message-ID: <20150113114253.GC19355@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 09:47:44AM +0100, Stefan Agner wrote:
> On 2015-01-12 03:45, fugang.duan at freescale.com wrote:
> > In additional, it is better to split the patch to two part with dts
> > and driver part.
> 
> Hm, this would mandate to have the device tree with the MDIO/phy-handle
> changes merged before the net changes to maintain bisect-ability.
> 
> @Dave/Shawn, what do you prefer?

I'm fine with dts change in the driver patch, if we have a good reason
for doing that.

Shawn
