From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Apr 2016 10:13:48 +0800
Subject: [PATCH 0/3 v2] arm64: defconfig updates
In-Reply-To: <HE1PR04MB1641EB5615245CC5A5BE041F8D630@HE1PR04MB1641.eurprd04.prod.outlook.com>
References: <1461167836-3163-1-git-send-email-stuart.yoder@nxp.com>
 <20160426101546.GI8870@tiger>
 <HE1PR04MB1641EB5615245CC5A5BE041F8D630@HE1PR04MB1641.eurprd04.prod.outlook.com>
Message-ID: <20160427021348.GF30692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 01:52:06PM +0000, Stuart Yoder wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > Sent: Tuesday, April 26, 2016 5:16 AM
> > To: Stuart Yoder <stuart.yoder@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com; will.deacon at arm.com;
> > kernel at pengutronix.de; Yang-Leo Li <leoyang.li@nxp.com>; Scott Wood <scott.wood@nxp.com>;
> > marc.zyngier at arm.com; mark.rutland at arm.com
> > Subject: Re: [PATCH 0/3 v2] arm64: defconfig updates
> > 
> > On Wed, Apr 20, 2016 at 10:57:16AM -0500, Stuart Yoder wrote:
> > > Stuart Yoder (3):
> > >   arm64: defconfig: cleanup the defconfig
> > >   arm64: defconfig: enable 48-bit virtual addresses
> > 
> > Applied these two.
> > 
> > >   arm64: defconfig: enable freescale/nxp config options
> > 
> > But this one doesn't apply to v4.6-rc1.
> 
> Yes.  There is a patch from Will that went into rc2 that was a major
> defconfig update:
>    431597b arm64: defconfig: updates for 4.6
> 
> ...so basing my patch on rc1 would have caused it not to apply to 
> later kernels.

Okay, I rebased my defconfig64 branch onto v4.6-rc2 and applied all 3
patches.

Shawn
