From: marex@denx.de (Marek Vasut)
Date: Mon, 18 Nov 2013 03:33:15 +0100
Subject: [PATCH] ARM: dts: imx53: Add USB support for M53EVK
In-Reply-To: <20131118023406.GO11014@S2101-09.ap.freescale.net>
References: <1384657490-5925-1-git-send-email-marex@denx.de>
 <20131118023406.GO11014@S2101-09.ap.freescale.net>
Message-ID: <201311180333.15738.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> On Sun, Nov 17, 2013 at 04:04:50AM +0100, Marek Vasut wrote:
> > @@ -332,3 +343,14 @@
> > 
> >  	pinctrl-0 = <&pinctrl_uart3>;
> >  	status = "okay";
> >  
> >  };
> > 
> > +
> > +&usbotg {
> > +	dr_mode = "peripheral";
> > +	status = "okay";
> > +};
> > +
> > +&usbh1 {
> > +	vbus-supply = <&reg_usbh1_vbus>;
> > +	phy_type = "utmi";
> > +	status = "okay";
> > +};
> 
> To maintain the alphabetical order, 'usbh1' should be put before
> 'usbotg'.  I just fixed it up and applied the patch.

Ah, you're right. Thank you and sorry for adding more burden unto you.

Best regards,
Marek Vasut
