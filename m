From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Feb 2014 13:23:01 +0800
Subject: [PATCH] ARM: dts: imx27-phytec-phycore-*: Add diagnostic PMIC LEDs
In-Reply-To: <1392611743.839161955@f87.i.mail.ru>
References: <1392464118-3353-1-git-send-email-shc_work@mail.ru>
 <20140217025527.GG9879@S2101-09.ap.freescale.net>
 <1392611743.839161955@f87.i.mail.ru>
Message-ID: <20140217052259.GH9879@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 08:35:43AM +0400, Alexander Shiyan wrote:
> > > +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> > > @@ -69,6 +69,12 @@
> > >  		fsl,mc13xxx-uses-adc;
> > >  		fsl,mc13xxx-uses-rtc;
> > >  
> > > +		pmicleds: leds {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +			led-control = <0x001 0x000 0x000 0x000 0x000 0x000>;
> > 
> > I can only see led-control mentioned in
> > Documentation/devicetree/bindings/mfd/mc13xxx.txt as below.
> > 
> > - leds : Contain the led nodes and initial register values in property
> > "led-control".
> > 
> > But I failed to see where this property is actually defined.
> 
> Not quite understand the question. Please rephrase.

The documentation of property "led-control" isn't so clear to me.  But
anyway it's not a problem of this patch.  Patch applied.

Shawn
