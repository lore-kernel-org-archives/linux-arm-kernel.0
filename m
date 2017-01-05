From: minghuan.lian@nxp.com (M.H. Lian)
Date: Thu, 5 Jan 2017 08:05:19 +0000
Subject: [PATCH 6/9] arm64: dts: ls1046a: add MSI dts node
In-Reply-To: <20170103171258.h5djzsarokjjldjx@rob-hp-laptop>
References: <1482829985-24421-1-git-send-email-Minghuan.Lian@nxp.com>
 <1482829985-24421-6-git-send-email-Minghuan.Lian@nxp.com>
 <20170103171258.h5djzsarokjjldjx@rob-hp-laptop>
Message-ID: <VI1PR04MB1615B59EAEDE661D10CF845FE8600@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for your comment.
I will change whitespace.

Thanks,
Minghuan

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Wednesday, January 04, 2017 1:13 AM
> To: M.H. Lian <minghuan.lian@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Marc Zyngier <marc.zyngier@arm.com>; Jason
> Cooper <jason@lakedaemon.net>; Roy Zang <roy.zang@nxp.com>; Mingkai
> Hu <mingkai.hu@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Leo Li
> <leoyang.li@nxp.com>; Scott Wood <scott.wood@nxp.com>
> Subject: Re: [PATCH 6/9] arm64: dts: ls1046a: add MSI dts node
> 
> On Tue, Dec 27, 2016 at 05:13:02PM +0800, Minghuan Lian wrote:
> > LS1046a includes 3 MSI controllers.
> > Each controller supports 128 interrupts.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > ---
> >  .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 31
> ++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-
> scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-
> controller/fsl,ls-scfg-msi.txt
> > index 2755cd1..54597b0 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-
> msi.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-
> msi.txt
> > @@ -6,6 +6,7 @@ Required properties:
> >  	      Layerscape PCIe MSI controller block such as:
> >                "fsl,ls1021a-msi"
> >                "fsl,ls1043a-msi"
> > +	      "fsl,ls1046a-msi"
> 
> Differing whitespace.
> 
> Otherwise,
> 
> Acked-by: Rob Herring <robh@kernel.org>
