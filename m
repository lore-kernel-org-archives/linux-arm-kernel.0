From: zhiqiang.hou@nxp.com (Zhiqiang Hou)
Date: Tue, 8 Mar 2016 02:10:11 +0000
Subject: [PATCH v3 1/2] Documentation: DT: Add entry for Freescale
 LS1043a-QDS board
In-Reply-To: <DB5PR0401MB1928313A537226265C54764291B10@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1457350232-12749-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <DB5PR0401MB1928313A537226265C54764291B10@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Message-ID: <AM4PR04MB214891F1E20C2D22537770EA84B20@AM4PR04MB2148.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

> -----Original Message-----
> From: Scott Wood
> Sent: 2016?3?8? 1:23
> To: Zhiqiang Hou <zhiqiang.hou@nxp.com>; devicetree at vger.kernel.org;
> robh+dt at kernel.org; mark.rutland at arm.com; pawel.moll at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; linux-arm-
> kernel at lists.infradead.org; catalin.marinas at arm.com; will.deacon at arm.com;
> shawnguo at kernel.org
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; Shaohui Xie <shaohui.xie@nxp.com>
> Subject: Re: [PATCH v3 1/2] Documentation: DT: Add entry for Freescale LS1043a-
> QDS board
> 
> On 03/07/2016 05:39 AM, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> > v3:
> >  - No change.
> >
> >  Documentation/devicetree/bindings/arm/fsl.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> > b/Documentation/devicetree/bindings/arm/fsl.txt
> > index 752a685..f504fdf 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> > @@ -134,6 +134,7 @@ Freescale ARMv8 based Layerscape SoC family Device
> > Tree Bindings  LS1043A ARMv8 based RDB Board  Required root node
> > properties:
> >      - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
> > +    - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";
> 
> "fsl,ls1043a-qds" is required for the "LS1043A ARMv8 based RDB Board"?

Thanks for your redress, and will correct this issue in v4.

Thanks,
Zhiqiang
