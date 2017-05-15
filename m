From: aisheng.dong@nxp.com (A.S. Dong)
Date: Mon, 15 May 2017 13:12:25 +0000
Subject: [PATCH 3/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding doc
In-Reply-To: <20170515125905.GV8471@dragon>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-5-git-send-email-aisheng.dong@nxp.com>
 <20170515114319.GP8471@dragon>
 <AM3PR04MB3069C90F23CF9C9CC84BA7580E10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20170515122032.GS8471@dragon>
 <AM3PR04MB3069C788C96EE2854C2C68080E10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20170515125905.GV8471@dragon>
Message-ID: <AM3PR04MB3063C9CFC02E03DE2B4C2ED80E10@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, May 15, 2017 8:59 PM
> To: A.S. Dong
> Cc: Mark Rutland; devicetree at vger.kernel.org; Andy Duan; Jacky Bai;
> linus.walleij at linaro.org; stefan at agner.ch; linux-gpio at vger.kernel.org; Rob
> Herring; kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 3/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding
> doc
> 
> On Mon, May 15, 2017 at 12:41:09PM +0000, A.S. Dong wrote:
> > > On Mon, May 15, 2017 at 12:06:19PM +0000, A.S. Dong wrote:
> > > > > > @@ -0,0 +1,56 @@
> > > > > > +* Freescale i.MX7ULP IOMUX Controller
> > > > > > +
> > > > > > +Please refer to fsl,imx-pinctrl.txt in this directory for
> > > > > > +common binding part and usage.
> > > > >
> > > > > Are imx7ulp-pinctrl bindings more alike to fsl,imx-pinctrl.txt
> > > > > or generic pinctrl-bindings.txt?  My personal feeling is that it
> > > > > might be better to take pinctrl-bindings.txt as the reference
> > > > > base and highlight how imx7ulp- pinctrl bindings differ from it.
> > > > >
> > > >
> > > > It seems still more like fsl,imx-pinctrl.txt.
> > > >
> > > > I know fsl,imx-pinctrl.txt is a bit out of date, especially after
> > > > we add generic pinconf.
> > > >
> > > > I plan to update it later after adding generic pin conf support to
> > > > legacy SoCs (MX6 & 7) as well, do you think it's ok?
> > >
> > > Please do not.  Let's use generic pinconf support only for new SoCs,
> > > and not bother with legacy SoCs.
> > >
> >
> > I wonder there may be some guys interested more in generic Pinconfig
> > format rather than old one when they add new board support, or someone
> > else adding the support for legacy SoCs as the pinctrl-imx core
> > already supports it after this patch series.
> 
> I would take this as an unnecessary churn on existing code and increase of
> maintenance burden.  So that's definitely a NO from me.
> 

Okay, personally I would be with you!

Regards
Dong Aisheng
