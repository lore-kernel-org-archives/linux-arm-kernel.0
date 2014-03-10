From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 10 Mar 2014 09:58:46 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzldIEFSTTogZHRzOiBpLk1YNTE6IEFkZCBhIHNlY29u?=
 =?UTF-8?B?ZCB1c2JwaHku?=
In-Reply-To: <c6475b21bb0d4252aded9e7a42f0d90c@BL2PR03MB226.namprd03.prod.outlook.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <1394427060.539541345@f354.i.mail.ru>
 <c6475b21bb0d4252aded9e7a42f0d90c@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <1394431126.727643973@f362.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????, 10 ????? 2014, 5:50 UTC ?? Peter Chen <Peter.Chen@freescale.com>:
>  
> > > >
> > > > diff --git a/arch/arm/boot/dts/imx51.dtsi
> > > > b/arch/arm/boot/dts/imx51.dtsi index e508e6f..917b6ed 100644
> > > > --- a/arch/arm/boot/dts/imx51.dtsi
> > > > +++ b/arch/arm/boot/dts/imx51.dtsi
> > > > @@ -100,6 +100,13 @@
> > > >  			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> > > >  			clock-names = "main_clk";
> > > >  		};
> > > > +
> > > > +		usbphy1: usbphy at 1 {
> > > > +			compatible = "usb-nop-xceiv";
> > > > +			reg = <1>;
> > > > +			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> > > > +			clock-names = "main_clk";
> > > > +		};
> > >
> > > Is this the ulpi phy for host1 controller? Why the clock is the same
> > > with utmi phy clock for otg controller.
> > 
> > As far as I know, for i.MX51 this is as it should be.
> > 
> 
> Are you sure? From clock file, they are different ccm clock gate.

clk-imx51-imx53.c ? I think you confuse with i.MX50/53.

---
