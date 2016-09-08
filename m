From: shaohui.xie@nxp.com (S.H. Xie)
Date: Thu, 8 Sep 2016 10:57:34 +0000
Subject: [PATCH 1/7] [v2] dt-bindings: fsl: updates bindings for some
 SoC-specific devices
In-Reply-To: <20160908023026.GC2533@x250>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-2-git-send-email-shh.xie@gmail.com>
 <20160908023026.GC2533@x250>
Message-ID: <DB5PR0401MB2183290FCC833282DB09A264E8FB0@DB5PR0401MB2183.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, September 08, 2016 10:30 AM
> To: shh.xie at gmail.com
> Cc: devicetree at vger.kernel.org; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> will.deacon at arm.com; linux-kernel at vger.kernel.org; S.H. Xie
> <shaohui.xie@nxp.com>; arnd at arndb.de
> Subject: Re: [PATCH 1/7] [v2] dt-bindings: fsl: updates bindings for some SoC-
> specific devices
> 
> On Mon, Sep 05, 2016 at 06:01:29PM +0800, shh.xie at gmail.com wrote:
> > From: Shaohui Xie <Shaohui.Xie@nxp.com>
> >
> > SCFG and DCFG are SoC-specific devices can be found on SoCs like
> > LS1021A, LS1043A and LS1046A, this patch updates bindings for SCFG and
> > DCFG to reflect more SoCs.
> >
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
> > ---
> > changes in V2:
> > new patch.
> >
> >  Documentation/devicetree/bindings/arm/fsl.txt | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> > b/Documentation/devicetree/bindings/arm/fsl.txt
> > index dbbc095..6f92d0b 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> > @@ -97,7 +97,7 @@ Freescale LS1021A Platform Device Tree Bindings
> > Required root node compatible properties:
> >    - compatible = "fsl,ls1021a";
> >
> > -Freescale LS1021A SoC-specific Device Tree Bindings
> > +Freescale SoC-specific Device Tree Bindings
> >  -------------------------------------------
> >
> >  Freescale SCFG
> > @@ -105,7 +105,10 @@ Freescale SCFG
> >  configuration and status registers for the chip. Such as getting PEX
> > port  status.
> >    Required properties:
> > -  - compatible: should be "fsl,ls1021a-scfg"
> > +  - compatible: Should contain a chip-specific compatible string,
> > +	Chip-specific strings are of the form "fsl,<chip>-scfg", such as:
> > +	"fsl,ls1021a-scfg"
> 
> Per Documentation/devicetree/bindings/submitting-patches.txt, the known values
> of "<chip>" should be documented.
Will add the supported chips in next version.

Thank you!

Shaohui
