From: peng.fan@nxp.com (Peng Fan)
Date: Mon, 13 Mar 2017 03:14:01 +0000
Subject: [PATCH 1/3] dt-bindings: imx-ocotp: add compatible string for
 i.MX7D/S
In-Reply-To: <a3f9ebba-6dfe-c7a3-fabf-1f5ac69ecafc@linaro.org>
References: <1488350454-23860-1-git-send-email-peng.fan@nxp.com>
 <a3f9ebba-6dfe-c7a3-fabf-1f5ac69ecafc@linaro.org>
Message-ID: <VI1PR04MB1166EA630AB6D829B1C8568888250@VI1PR04MB1166.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Srinivas Kandagatla [mailto:srinivas.kandagatla at linaro.org]
> Sent: Friday, March 03, 2017 6:12 PM
> To: Peng Fan <peng.fan@nxp.com>; shawnguo at kernel.org;
> maxime.ripard at free-electrons.com
> Cc: devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; van.freenix at gmail.com; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> Subject: Re: [PATCH 1/3] dt-bindings: imx-ocotp: add compatible string for
> i.MX7D/S
> 
> 
> 
> On 01/03/17 06:40, Peng Fan wrote:
> > Add compatible string for i.MX7D/S
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> Thanks for the patch, I will queue both nvmem driver changes and bindings
> changes, via Greg's chars-misc tree.
> But the DT changes have to go via arm-soc tree.

Thanks, Srini.

Shawn may take the DT changes, if it is ok.

Thanks,
Peng.
> 
> Thanks,
> srini
> > diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> > b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> > index 966a72e..bbde2e4 100644
> > --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> > +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> > @@ -9,6 +9,7 @@ Required properties:
> >  	"fsl,imx6sl-ocotp" (i.MX6SL), or
> >  	"fsl,imx6sx-ocotp" (i.MX6SX),
> >  	"fsl,imx6ul-ocotp" (i.MX6UL),
> > +	"fsl,imx7d-ocotp" (i.MX7D/S),
> >  	followed by "syscon".
> >  - reg: Should contain the register base and length.
> >  - clocks: Should contain a phandle pointing to the gated peripheral clock.
> >
