From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 May 2017 10:36:22 +0200
Subject: [PATCH/RFT v3 renesas-devel] ARM: dts: silk: Enable UHS-I SDR-50
In-Reply-To: <20170502082247.GB2640@katana>
References: <20170426080024.8391-1-horms+renesas@verge.net.au>
 <20170426081334.11846-1-horms+renesas@verge.net.au>
 <20170502082247.GB2640@katana>
Message-ID: <20170502083622.GB32059@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 10:22:47AM +0200, Wolfram Sang wrote:
> > +	sdhi1_pins_uhs: sd1_uhs {
> > +		groups = "sdhi1_data4", "sdhi1_ctrl";
> > +		function = "sdhi1";
> > +		power-source = <1800>;
> >  	};
> >  
> >  	qspi_pins: qspi {
> > @@ -338,11 +345,13 @@
> >  
> >  &sdhi1 {
> >  	pinctrl-0 = <&sdhi1_pins>;
> > -	pinctrl-names = "default";
> > +	pinctrl-1 = <&sdhi0_pins_uhs>;
> 
> This must be sdhi1_pins_uhs.

Thanks, will fix.
